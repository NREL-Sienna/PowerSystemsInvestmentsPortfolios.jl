#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct RetrofitTechnology <: IS.SupplementalAttribute
        name::String
        retrofit_id::Int64
        retrofit_efficiency::Dict{PrimeMovers,Dict{String, Float64}}
        internal::InfrastructureSystemsInternal
        ext::Dict
        retrofit_capacity::Float64
    end



# Arguments
- `name::String`: The technology name
- `retrofit_id::Int64`: (default: `0`) Unique identifier to group retrofittable source technologies with retrofit options inside the same zone.
- `retrofit_efficiency::Dict{PrimeMovers,Dict{String, Float64}}`: (default: `Dict()`) Dictionary of Efficiency of the retrofit technology.
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `retrofit_capacity::Float64`: (default: `0.0`) Amount of existing capacity for technology that can be retrofitted
"""
mutable struct RetrofitTechnology <: IS.SupplementalAttribute
    "The technology name"
    name::String
    "Unique identifier to group retrofittable source technologies with retrofit options inside the same zone."
    retrofit_id::Int64
    "Dictionary of Efficiency of the retrofit technology."
    retrofit_efficiency::Dict{PrimeMovers,Dict{String, Float64}}
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Amount of existing capacity for technology that can be retrofitted"
    retrofit_capacity::Float64
end


function RetrofitTechnology(; name, retrofit_id=0, retrofit_efficiency=Dict(), internal=InfrastructureSystemsInternal(), ext=Dict(), retrofit_capacity=0.0, )
    RetrofitTechnology(name, retrofit_id, retrofit_efficiency, internal, ext, retrofit_capacity, )
end

"""Get [`RetrofitTechnology`](@ref) `name`."""
get_name(value::RetrofitTechnology) = value.name
"""Get [`RetrofitTechnology`](@ref) `retrofit_id`."""
get_retrofit_id(value::RetrofitTechnology) = value.retrofit_id
"""Get [`RetrofitTechnology`](@ref) `retrofit_efficiency`."""
get_retrofit_efficiency(value::RetrofitTechnology) = value.retrofit_efficiency
"""Get [`RetrofitTechnology`](@ref) `internal`."""
get_internal(value::RetrofitTechnology) = value.internal
"""Get [`RetrofitTechnology`](@ref) `ext`."""
get_ext(value::RetrofitTechnology) = value.ext
"""Get [`RetrofitTechnology`](@ref) `retrofit_capacity`."""
get_retrofit_capacity(value::RetrofitTechnology) = value.retrofit_capacity

"""Set [`RetrofitTechnology`](@ref) `name`."""
set_name!(value::RetrofitTechnology, val) = value.name = val
"""Set [`RetrofitTechnology`](@ref) `retrofit_id`."""
set_retrofit_id!(value::RetrofitTechnology, val) = value.retrofit_id = val
"""Set [`RetrofitTechnology`](@ref) `retrofit_efficiency`."""
set_retrofit_efficiency!(value::RetrofitTechnology, val) = value.retrofit_efficiency = val
"""Set [`RetrofitTechnology`](@ref) `internal`."""
set_internal!(value::RetrofitTechnology, val) = value.internal = val
"""Set [`RetrofitTechnology`](@ref) `ext`."""
set_ext!(value::RetrofitTechnology, val) = value.ext = val
"""Set [`RetrofitTechnology`](@ref) `retrofit_capacity`."""
set_retrofit_capacity!(value::RetrofitTechnology, val) = value.retrofit_capacity = val
