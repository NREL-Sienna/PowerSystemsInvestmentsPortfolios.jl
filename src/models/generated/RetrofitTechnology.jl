#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct RetrofitTechnology{T <: PSY.Generator} <: Technology
        retrofit_id::Dict{PrimeMovers,Dict{String, Int64}}
        retrofit_efficiency::Dict{PrimeMovers,Dict{String, Float64}}
        internal::InfrastructureSystemsInternal
        ext::Dict
        can_retrofit::Dict{PrimeMovers,Dict{String, Int64}}
    end



# Arguments
- `retrofit_id::Dict{PrimeMovers,Dict{String, Int64}}`: (default: `Dict()`) Dictionary of unique identifiers to group retrofittable source technologies with retrofit options inside the same zone.
- `retrofit_efficiency::Dict{PrimeMovers,Dict{String, Float64}}`: (default: `Dict()`) Dictionary of Efficiency of the retrofit technology.
- `internal::InfrastructureSystemsInternal`: (default: `InfrastructureSystemsInternal()`) Internal field
- `ext::Dict`: (default: `Dict()`) Option for providing additional data
- `can_retrofit::Dict{PrimeMovers,Dict{String, Int64}}`: (default: `Dict()`) Dictionary of PrimeMovers in each region that can retire
"""
mutable struct RetrofitTechnology{T <: PSY.Generator} <: Technology
    "Dictionary of unique identifiers to group retrofittable source technologies with retrofit options inside the same zone."
    retrofit_id::Dict{PrimeMovers,Dict{String, Int64}}
    "Dictionary of Efficiency of the retrofit technology."
    retrofit_efficiency::Dict{PrimeMovers,Dict{String, Float64}}
    "Internal field"
    internal::InfrastructureSystemsInternal
    "Option for providing additional data"
    ext::Dict
    "Dictionary of PrimeMovers in each region that can retire"
    can_retrofit::Dict{PrimeMovers,Dict{String, Int64}}
end


function RetrofitTechnology{T}(; retrofit_id=Dict(), retrofit_efficiency=Dict(), internal=InfrastructureSystemsInternal(), ext=Dict(), can_retrofit=Dict(), ) where T <: PSY.Generator
    RetrofitTechnology{T}(retrofit_id, retrofit_efficiency, internal, ext, can_retrofit, )
end

# Constructor for demo purposes; non-functional.
function RetrofitTechnology{T}(::Nothing) where T <: PSY.Generator
    RetrofitTechnology{T}(;
        retrofit_id=Dict(),
        retrofit_efficiency=Dict(),
        internal=Dict(),
        ext=Dict(),
        can_retrofit=Dict(),
    )
end

"""Get [`RetrofitTechnology`](@ref) `retrofit_id`."""
get_retrofit_id(value::RetrofitTechnology) = value.retrofit_id
"""Get [`RetrofitTechnology`](@ref) `retrofit_efficiency`."""
get_retrofit_efficiency(value::RetrofitTechnology) = value.retrofit_efficiency
"""Get [`RetrofitTechnology`](@ref) `internal`."""
get_internal(value::RetrofitTechnology) = value.internal
"""Get [`RetrofitTechnology`](@ref) `ext`."""
get_ext(value::RetrofitTechnology) = value.ext
"""Get [`RetrofitTechnology`](@ref) `can_retrofit`."""
get_can_retrofit(value::RetrofitTechnology) = value.can_retrofit

"""Set [`RetrofitTechnology`](@ref) `retrofit_id`."""
set_retrofit_id!(value::RetrofitTechnology, val) = value.retrofit_id = val
"""Set [`RetrofitTechnology`](@ref) `retrofit_efficiency`."""
set_retrofit_efficiency!(value::RetrofitTechnology, val) = value.retrofit_efficiency = val
"""Set [`RetrofitTechnology`](@ref) `internal`."""
set_internal!(value::RetrofitTechnology, val) = value.internal = val
"""Set [`RetrofitTechnology`](@ref) `ext`."""
set_ext!(value::RetrofitTechnology, val) = value.ext = val
"""Set [`RetrofitTechnology`](@ref) `can_retrofit`."""
set_can_retrofit!(value::RetrofitTechnology, val) = value.can_retrofit = val
