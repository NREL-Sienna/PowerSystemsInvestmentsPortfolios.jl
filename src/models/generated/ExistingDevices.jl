#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct ExistingDevices <: IS.SupplementalAttribute
        internal::InfrastructureSystemsInternal
        existing_devices::Vector{String}
        ext::Dict
    end

Supplemental attributed used to map technologies in a portfolio to the existing system. For example, contains a list of existing generators that correspond to a SupplyTechnology.

# Arguments
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) (**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference
- `existing_devices::Vector{String}`: (default: `Vector()`) List of individual existing devices to map to a specific technology in the portfolio
- `ext::Dict`: (default: `Dict()`) Optional dictionary to provide additional data
"""
mutable struct ExistingDevices <: IS.SupplementalAttribute
    "(**Do not modify.**) PowerSystemsInvestmentsPortfolios.jl internal reference"
    internal::InfrastructureSystemsInternal
    "List of individual existing devices to map to a specific technology in the portfolio"
    existing_devices::Vector{String}
    "Optional dictionary to provide additional data"
    ext::Dict
end


function ExistingDevices(; internal=InfrastructureSystemsInternal(), existing_devices=Vector(), ext=Dict(), )
    ExistingDevices(internal, existing_devices, ext, )
end

# Constructor for demo purposes; non-functional.
function ExistingDevices(::Nothing)
    ExistingDevices(;
        internal=Dict(),
        existing_devices=Dict(),
        ext=Dict(),
    )
end

"""Get [`ExistingDevices`](@ref) `internal`."""
get_internal(value::ExistingDevices) = value.internal
"""Get [`ExistingDevices`](@ref) `existing_devices`."""
get_existing_devices(value::ExistingDevices) = value.existing_devices
"""Get [`ExistingDevices`](@ref) `ext`."""
get_ext(value::ExistingDevices) = value.ext

"""Set [`ExistingDevices`](@ref) `internal`."""
set_internal!(value::ExistingDevices, val) = value.internal = val
"""Set [`ExistingDevices`](@ref) `existing_devices`."""
set_existing_devices!(value::ExistingDevices, val) = value.existing_devices = val
"""Set [`ExistingDevices`](@ref) `ext`."""
set_ext!(value::ExistingDevices, val) = value.ext = val

function serialize_openapi_struct(technology::ExistingDevices, vals...)
    base_struct = APIServer.ExistingDevices(; vals...)
    return base_struct
end

function deserialize_openapi_struct(::Type{<:ExistingDevices}, vals::Dict)
    return IS.deserialize_struct(APIServer.ExistingDevices, vals)
end
