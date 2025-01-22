function Base.show(io::IO, ::MIME"text/plain", p::Portfolio)
    show_portfolio_table(io, p; backend=Val(:auto))

    components = p.data.components
    tech_types = Vector{DataType}()
    for component_type in keys(components.data)
        if component_type <: Technology
            push!(tech_types, component_type)
        end
    end

    if !isempty(tech_types)
        show_technologies_table(io, p; backend=Val(:auto))
    end

    println(io)
    return
end

function Base.show(io::IO, ::MIME"text/html", p::Portfolio)
    show_portfolio_table(io, p; backend=Val(:html), standalone=false)
    println(io)

    components = p.data.components
    tech_types = Vector{DataType}()
    for component_type in keys(components.data)
        if component_type <: Technology
            push!(tech_types, component_type)
        end
    end
    if !isempty(tech_types)
        show_technologies_table(
            io,
            p;
            backend=Val(:html),
            tf=PrettyTables.tf_html_simple,
            standalone=false,
        )
    end
    return
end

function show_portfolio_table(io::IO, p::Portfolio; kwargs...)
    header = ["Property", "Value"]
    table = [
        "Name" isnothing(get_name(p)) ? "" : get_name(p)
        "Description" isnothing(get_description(p)) ? "" : get_description(p)
        "Aggregation" string(p.aggregation)
        #"Discount Rate" string(p.discount_rate)
    ]
    PrettyTables.pretty_table(
        io,
        table;
        header=header,
        title="Portfolio",
        alignment=:l,
        kwargs...,
    )
    return
end

function show_technologies_table(io::IO, p::Portfolio; kwargs...)
    tech_header = ["Type", "Count"]
    components = p.data.components
    tech_types = Vector{DataType}()
    for component_type in keys(components.data)
        if component_type <: Technology
            push!(tech_types, component_type)
        end
    end
    tech_data = Array{Any, 2}(undef, length(tech_types), length(tech_header))

    tech_type_names = [(nameof(x), x) for x in tech_types]
    sort!(tech_type_names; by=x -> x[1])
    for (i, (type_name, type)) in enumerate(tech_type_names)
        vals = components.data[type]
        tech_data[i, 1] = type_name
        tech_data[i, 2] = length(vals)
    end

    if !isempty(tech_types)
        println(io)
        PrettyTables.pretty_table(
            io,
            tech_data;
            header=tech_header,
            title="Technologies",
            alignment=:l,
            kwargs...,
        )
    end
end
