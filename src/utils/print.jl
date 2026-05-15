function Base.show(io::IO, ::MIME"text/plain", ist::Technology)
    print(io, summary(ist), ":")
    for name in fieldnames(typeof(ist))
        obj = getproperty(ist, name)
        getter_name = Symbol("get_$name")
        if (obj isa InfrastructureSystemsInternal)
            print(io, "\n   ")
            show(io, MIME"text/plain"(), obj.units_info)
            continue
        elseif obj isa IS.InfrastructureSystemsType ||
               obj isa Vector{<:IS.InfrastructureSystemsComponent}
            val = summary(getproperty(ist, name))
        elseif PSY.hasproperty(PowerSystemsInvestmentsPortfolios, getter_name)
            getter_func = PSY.getproperty(PowerSystemsInvestmentsPortfolios, getter_name)
            val = getter_func(ist)
        else
            val = getproperty(ist, name)
        end
        print(io, "\n   ", name, ": ", val)
    end
    print(
        io,
        "\n   ",
        "has_supplemental_attributes",
        ": ",
        string(PSY.has_supplemental_attributes(ist)),
    )
    print(io, "\n   ", "has_time_series", ": ", string(PSY.has_time_series(ist)))
    return
end
