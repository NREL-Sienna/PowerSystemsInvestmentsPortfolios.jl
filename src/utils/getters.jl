"""
Functions to calculate the existing capacity associated with a PSIP Technology.

If a technology has an ExistingCapacity supplemental attribute, it will use the names stored in the attribute
to retreive relevant components from the base system and calcuate their total rated capacity.
"""

get_max(x::MinMax) = x.max
get_min(x::MinMax) = x.min
get_in(x::InOut) = x.in
get_out(x::InOut) = x.out

get_parameter_type(t::SupplyTechnology{T}) where {T} = T
get_parameter_type(t::StorageTechnology{T}) where {T} = T
get_parameter_type(t::AggregateTransportTechnology{T}) where {T} = T
get_parameter_type(t::NodalACTransportTechnology{T}) where {T} = T
get_parameter_type(t::NodalHVDCTransportTechnology{T}) where {T} = T
get_parameter_type(t::DemandRequirement{T}) where {T} = T
get_parameter_type(t::DemandSideTechnology{T}) where {T} = T

function get_existing_capacity_mw(
    p::Portfolio,
    t::Union{ResourceTechnology, TransmissionTechnology},
)
    if typeof(t) <: ColocatedSupplyStorageTechnology
        @warn "Co-located technologies are not supported for ExistingCapacity, assuming an existing capacity of 0"
        return 0.0
    end

    if !is_new(t)
        attr = IS.get_supplemental_attributes(ExistingCapacity, t)
        if length(attr) > 1
            @warn "Multiple ExistingCapacity attributes are attached to this technology, assuming a capacity of 0.0"
            return 0.0
        end

        gen_names = get_existing_technologies(only(attr))
        if length(gen_names) == 0
            @warn "No names listed in ExistingCapacity attribute, returning capacity of 0.0."
            return 0.0
        end

        comp = PSY.get_component.(get_parameter_type(t), Ref(p.base_system), gen_names)

        # Check if any of the components returned nothing
        filtered_comp = filter(x -> !isnothing(x), comp)
        if length(filtered_comp) != length(gen_names)
            @error "Not all names in ExistingCapacity matched generators in the base system"
        end

        return sum(PSY.get_rating(t) * PSY.get_base_power(t) for t in comp)
    else
        return 0.0
    end
end

function get_existing_capacity_mwh(p::Portfolio, t::StorageTechnology)
    if !is_new(t)
        attr = IS.get_supplemental_attributes(ExistingCapacity, t)
        if length(attr) > 1
            @warn "Multiple ExistingCapacity attributes are attached to this technology, assuming a capacity of 0.0"
            return 0.0
        end
        gen_names = get_existing_technologies(only(attr))
        comp = PSY.get_component.(get_parameter_type(t), Ref(p.base_system), gen_names)

        # Check if any of the components returned nothing
        filtered_comp = filter(x -> !isnothing(x), comp)
        if length(filtered_comp) != length(gen_names)
            @error "Not all names in ExistingCapacity matched generators in the base system"
        end

        return sum(PSY.get_storage_capacity(t) * PSY.get_base_power(t) for t in comp)
    else
        return 0.0
    end
end

"""
Determines if a technology is a completely new build and is not associated with any pre-existing capacity
"""
is_new(t::Technology) = !(IS.has_supplemental_attributes(ExistingCapacity, t))

"""
Get constant heat rate value from FuelCurve stored in a SupplyTechnology
"""
get_heat_rate(t::SupplyTechnology) =
    IS.get_proportional_term(IS.get_value_curve(PSY.get_variable(get_operation_costs(t))))

"""
Get constant fuel cost from FuelCurve stored in a SupplyTechnology
"""
get_fuel_cost(t::SupplyTechnology) =
    IS.get_fuel_cost(PSY.get_variable(get_operation_costs(t)))

"""
Get constant variable OM costs from OperationalCost in a SupplyTechnology
"""
get_variable_cost(t::SupplyTechnology) =
    IS.get_proportional_term(IS.get_vom_cost(PSY.get_variable(get_operation_costs(t))))

"""
Get constant variable OM costs for storage charging from OperationalCost in a StorageTechnology
"""
get_variable_cost_charge(t::StorageTechnology) = PSY.get_proportional_term(
    PSY.get_vom_cost(PSY.get_charge_variable_cost(get_operation_costs(t))),
)

"""
Get constant variable OM costs for storage discharging from OperationalCost in a StorageTechnology
"""
get_variable_cost_discharge(t::StorageTechnology) = PSY.get_proportional_term(
    PSY.get_vom_cost(PSY.get_discharge_variable_cost(get_operation_costs(t))),
)

"""
Get constant fixed OM costs from OperationalCost for a SupplyTechnology
"""
get_fixed_cost(t::Technology) = PSY.get_fixed(get_operation_costs(t))

"""
Get constant fixed OM costs for storage charge from OperationalCost in a StorageTechnology
"""
get_fixed_cost_charge(t::StorageTechnology) = PSY.get_proportional_term(
    PSY.get_value_curve(PSY.get_charge_variable_cost(get_operation_costs(t))),
)

"""
Get constant fixed OM costs for storage discharge from OperationalCost in a StorageTechnology
"""
get_fixed_cost_discharge(t::StorageTechnology) = PSY.get_proportional_term(
    PSY.get_value_curve(PSY.get_discharge_variable_cost(get_operation_costs(t))),
)
