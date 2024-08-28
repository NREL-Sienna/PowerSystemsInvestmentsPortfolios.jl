#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct RetrofitCapacity <: IS.SupplementalAttribute
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
mutable struct RetrofitCapacity <: IS.SupplementalAttribute
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


function RetrofitCapacity(; name, retrofit_id=0, retrofit_efficiency=Dict(), internal=InfrastructureSystemsInternal(), ext=Dict(), retrofit_capacity=0.0, )
    RetrofitCapacity(name, retrofit_id, retrofit_efficiency, internal, ext, retrofit_capacity, )
end

"""Get [`RetrofitCapacity`](@ref) `name`."""
get_name(value::RetrofitCapacity) = value.name
"""Get [`RetrofitCapacity`](@ref) `retrofit_id`."""
get_retrofit_id(value::RetrofitCapacity) = value.retrofit_id
"""Get [`RetrofitCapacity`](@ref) `retrofit_efficiency`."""
get_retrofit_efficiency(value::RetrofitCapacity) = value.retrofit_efficiency
"""Get [`RetrofitCapacity`](@ref) `internal`."""
get_internal(value::RetrofitCapacity) = value.internal
"""Get [`RetrofitCapacity`](@ref) `ext`."""
get_ext(value::RetrofitCapacity) = value.ext
"""Get [`RetrofitCapacity`](@ref) `retrofit_capacity`."""
get_retrofit_capacity(value::RetrofitCapacity) = value.retrofit_capacity

"""Set [`RetrofitCapacity`](@ref) `name`."""
set_name!(value::RetrofitCapacity, val) = value.name = val
"""Set [`RetrofitCapacity`](@ref) `retrofit_id`."""
set_retrofit_id!(value::RetrofitCapacity, val) = value.retrofit_id = val
"""Set [`RetrofitCapacity`](@ref) `retrofit_efficiency`."""
set_retrofit_efficiency!(value::RetrofitCapacity, val) = value.retrofit_efficiency = val
"""Set [`RetrofitCapacity`](@ref) `internal`."""
set_internal!(value::RetrofitCapacity, val) = value.internal = val
"""Set [`RetrofitCapacity`](@ref) `ext`."""
set_ext!(value::RetrofitCapacity, val) = value.ext = val
"""Set [`RetrofitCapacity`](@ref) `retrofit_capacity`."""
set_retrofit_capacity!(value::RetrofitCapacity, val) = value.retrofit_capacity = val
