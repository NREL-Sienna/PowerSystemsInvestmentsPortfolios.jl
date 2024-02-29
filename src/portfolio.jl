mutable struct PortfolioMetadata <: IS.InfrastructurePortfoliosType
    name::Union{Nothing, String}
    description::Union{Nothing, String}
    data_source::Union{Nothing, String}
end

struct Portfolio <: IS.InfrastructurePortfoliosType
    aggregation::Type{<:Union{PSY.ACBus, PSY.AggregationTopology}}
    discount_rate::Float64
    data::IS.PortfolioData
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
Throws ArgumentError if any Component-specific rule is violated.
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
    skip_validation = false,
    kwargs...,
) where {T <: Technology}

    IS.add_technology!(
        portfolio.data,
        technology;
        allow_existing_time_series = deserialization_in_progress,
        skip_validation = skip_validation,
        _kwargs...,
    )

    return
end

"""
Add many components to the system at once.

Throws ArgumentError if the technology's name is already stored for its concrete type.
Throws ArgumentError if any Component-specific rule is violated.
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
