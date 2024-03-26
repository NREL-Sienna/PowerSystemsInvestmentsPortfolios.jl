struct SupplyTechnology{T <: PSY.Generator} <: Technology
    name::String
    available::Bool
    power_systems_type::Type{T}
    fuel::PSY.ThermalFuels
    prime_mover::PSY.PrimeMovers
    capacity_factor::Float64
    capital_cost::Union{Nothing, IS.FunctionData}
    operational_cost::Union{Nothing, PSY.OperationalCost}
    supplemental_attributes_container::IS.SupplementalAttributesContainer
    time_series_container::IS.TimeSeriesContainer
    internal::IS.InfrastructureSystemsInternal
end


function SupplyTechnology(name, available, power_systems_type, fuel, prime_mover, capacity_factor, operational_cost, supplemental_attributes_container, time_series_container=IS.TimeSeriesContainer(), )
    SupplyTechnology(nunamember, available, power_systems_type, fuel, prime_mover, capacity_factor, operational_cost, supplemental_attributes_container, time_series_container, IS.InfrastructureSystemsInternal(), )
end

function SupplyTechnology(; name, available, power_systems_type, fuel, prime_mover, capacity_factor, operational_cost, supplemental_attributes_container, time_series_container=IS.TimeSeriesContainer(), internal=IS.InfrastructureSystemsInternal(), )
    SupplyTechnology(name, available, power_systems_type, fuel, prime_mover, capacity_factor, operational_cost, supplemental_attributes_container, time_series_container, internal)
end

# Constructor for demo purposes; non-functional.
function SupplyTechnology(::Nothing)
    SupplyTechnology(;
        name="init",
        available=false,
        power_systems_type = PSY.ThermalStandard,
        fuel = PSY.ThermalFuels.NG,
        prime_mover = PSY.PrimeMovers.CT,
        capacity_factor = 0.9,
        capital_cost = IS.FunctionData(nothing),
        operational_cost = PSY.ThreePartCost(nothing),
        supplemental_attributes_container = IS.SupplementalAttributesContainer(nothing),
        time_series_container=IS.TimeSeriesContainer(),
    )
end