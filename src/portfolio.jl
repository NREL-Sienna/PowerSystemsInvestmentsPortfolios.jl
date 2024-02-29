mutable struct PortfolioMetadata <: IS.InfrastructurePortfoliosType
    name::Union{Nothing, String}
    description::Union{Nothing, String}
    data_source::Union{Nothing, String}
end

struct Portfolio <: IS.InfrastructurePortfoliosType
    aggregation::Type{<:Union{PSY.ACBus, PSY.AggregationTopology}}
    discount_rate::Float64
    portfolio_data::IS.PortfolioData # Inputs to the model
    investment_data::Dict # Investment decisions container i.e., model outputs. Container TBD
    metadata::PortfolioMetadata
    time_series_directory::Union{Nothing, String}
    time_series_container::InfrastructurePortfolios.TimeSeriesContainer
    internal::IS.InfrastructurePortfoliosInternal
end

"""
Return the internal of the portfolio
"""
IS.get_internal(val::Portfolio) = val.internal

"""
Return a user-modifiable dictionary to store extra information.
"""
get_ext(val::Portfolio) = IS.get_ext(val.internal)

"""
Set the name of the portfolio.
"""
set_name!(val::Portfolio, name::AbstractString) = val.metadata.name = name

"""
Get the name of the portfolio.
"""
get_name(val::Portfolio) = val.metadata.name

"""
Set the description of the portfolio.
"""
set_description!(val::Portfolio, description::AbstractString) =
    val.metadata.description = description

"""
Get the description of the portfolio.
"""
get_description(val::Portfolio) = val.metadata.description

"""
Get the description of the portfolio.
"""
get_description(val::Portfolio) = val.metadata.description

"""
Add a technology to the portfoliotem.

Throws ArgumentError if the technology's name is already stored for its concrete type.
Throws ArgumentError if any Technology-specific rule is violated.
Throws InvalidValue if any of the technology's field values are outside of defined valid
range.

# Examples

```julia
portfolio = Portfolio(...)

# Add a single technology.
add_technology!(portfolio, bus)

# Add many at once.
foreach(x -> add_technology!(portfolio, x), Iterators.flatten((buses, generators)))
```
"""
function add_technology!(
    portfolio::Portfolio,
    technology::T;
    skip_validation=false,
    kwargs...,
) where {T <: Technology}
    IS.add_technology!(
        portfolio.data,
        technology;
        allow_existing_time_series=deserialization_in_progress,
        skip_validation=skip_validation,
        _kwargs...,
    )

    return
end

"""
Add many technologies to the portfoliotem at once.

Throws ArgumentError if the technology's name is already stored for its concrete type.
Throws ArgumentError if any Technology-specific rule is violated.
Throws InvalidValue if any of the technology's field values are outside of defined valid
range.

# Examples

```julia
portfolio = Portfolio(100.0)

buses = [bus1, bus2, bus3]
generators = [gen1, gen2, gen3]
foreach(x -> add_technologies!(portfolio, x), Iterators.flatten((buses, generators)))
```
"""
function add_technologies!(::Portfolio, technologies)
    foreach(x -> add_technology!(portfolio, x), technologies)
    return
end

"""
Get the technology of type T with name. Returns nothing if no technology matches. If T is an abstract
type then the names of technologies across all subtypes of T must be unique.

See [`get_technologies_by_name`](@ref) for abstract types with non-unique names across subtypes.

Throws ArgumentError if T is not a concrete type and there is more than one technology with
requested name
"""
function get_technology(
    ::Type{T},
    portfolio::Portfolio,
    name::AbstractString,
) where {T <: Technology}
    return IS.get_component(T, portfolio.data, name)
end

"""
Returns an iterator of technologies. T can be concrete or abstract.
Call collect on the result if an array is desired.

# Examples

```julia
iter = Portfolio.get_technologies(ThermalStandard, portfolio)
iter = Portfolio.get_technologies(Generator, portfolio)
iter = Portfolio.get_technologies(x -> Portfolio.get_available(x), Generator, portfolio)
thermal_gens = get_technologies(ThermalStandard, portfolio) do gen
    get_available(gen)
end
generators = collect(Portfolio.get_technologies(Generator, portfolio))
```

See also: [`iterate_technologies`](@ref)
"""
function get_technologies(
    ::Type{T},
    portfolio::Portfolio;
    subportfoliotem_name=nothing,
) where {T <: Technology}
    return IS.get_components(T, portfolio.data; subportfoliotem_name=subportfoliotem_name)
end

function get_technologies(
    filter_func::Function,
    ::Type{T},
    portfolio::Portfolio;
    subportfoliotem_name=nothing,
) where {T <: Technology}
    return IS.get_components(
        filter_func,
        T,
        portfolio.data;
        subportfoliotem_name=subportfoliotem_name,
    )
end

"""
Add time series data to a component.

Throws ArgumentError if the component is not stored in the system.
"""
function add_time_series!(
    portfolio::Portfolio,
    component::Technology,
    time_series::TimeSeriesData,
)
    return IS.add_time_series!(portfolio.data, component, time_series)
end

"""
Add the same time series data to multiple components.

This is significantly more efficent than calling `add_time_series!` for each component
individually with the same data because in this case, only one time series array is stored.

Throws ArgumentError if a component is not stored in the system.
"""
function add_time_series!(portfolio::Portfolio, technologies, time_series::TimeSeriesData)
    return IS.add_time_series!(portfolio.data, technologies, time_series)
end

"""
Return the compression settings used for system data such as time series arrays.
"""
get_compression_settings(portfolio::Portfolio) = IS.get_compression_settings(portfolio.data)

"""
Return the resolution for all time series.
"""
get_time_series_resolution(portfolio::Portfolio) = IS.get_time_series_resolution(portfolio.data)

"""
Remove all time series data from the system.
"""
function clear_time_series!(portfolio::Portfolio)
    return IS.clear_time_series!(portfolio.data)
end

"""
Remove the time series data for a component and time series type.
"""
function remove_time_series!(
    portfolio::Portfolio,
    ::Type{T},
    component::Component,
    name::String,
) where {T <: TimeSeriesData}
    return IS.remove_time_series!(portfolio.data, T, component, name)
end

"""
Remove all the time series data for a time series type.
"""
function remove_time_series!(portfolio::Portfolio, ::Type{T}) where {T <: TimeSeriesData}
    return IS.remove_time_series!(portfolio.data, T)
end

function IS.serialize(portfolio::Portfolio)
    return
end

function IS.deserialize(
    ::Type{Portfolio},
    filename::AbstractString;
    time_series_read_only = false,
    time_series_directory = nothing,
    kwargs...,
)
    portfolio = nothing
    return portfolio
end

function deserialize_components!(portfolio::Portfolio, raw)
end
