#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct RetireableTechnology{T <: PSY.Generator} <: Technology
        can_retire::Dict{PrimeMovers,Dict{String, Int64}}
        internal::InfrastructureSystemsInternal
        ext::Dict
    end



# Arguments
- `can_retire::Dict{PrimeMovers,Dict{String, Int64}}`: (default: `Dict()`) Dictionary of PrimeMovers in each region that can retire
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
"""
mutable struct RetireableTechnology{T <: PSY.Generator} <: Technology
    "Dictionary of PrimeMovers in each region that can retire"
    can_retire::Dict{PrimeMovers,Dict{String, Int64}}
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
end


function RetireableTechnology{T}(; can_retire=Dict(), internal=InfrastructureSystemsInternal(), ext=Dict(), ) where T <: PSY.Generator
    RetireableTechnology{T}(can_retire, internal, ext, )
end

# Constructor for demo purposes; non-functional.
function RetireableTechnology{T}(::Nothing) where T <: PSY.Generator
    RetireableTechnology{T}(;
        can_retire=Dict(),
        internal=Dict(),
        ext=Dict(),
    )
end

"""Get [`RetireableTechnology`](@ref) `can_retire`."""
get_can_retire(value::RetireableTechnology) = value.can_retire
"""Get [`RetireableTechnology`](@ref) `internal`."""
get_internal(value::RetireableTechnology) = value.internal
"""Get [`RetireableTechnology`](@ref) `ext`."""
get_ext(value::RetireableTechnology) = value.ext

"""Set [`RetireableTechnology`](@ref) `can_retire`."""
set_can_retire!(value::RetireableTechnology, val) = value.can_retire = val
"""Set [`RetireableTechnology`](@ref) `internal`."""
set_internal!(value::RetireableTechnology, val) = value.internal = val
"""Set [`RetireableTechnology`](@ref) `ext`."""
set_ext!(value::RetireableTechnology, val) = value.ext = val
