# PrettyTables v3 removed predefined HTML table format recipes.
# This reproduces the v2 tf_html_simple CSS for backwards-compatible Jupyter output.
const tf_html_simple = PrettyTables.HtmlTableFormat(;
    css = """
    table, td, th {
        border-collapse: collapse;
        font-family: sans-serif;
    }

    td, th {
        border-bottom: 0;
        padding: 4px
    }

    tr:nth-child(odd) {
        background: #eee;
    }

    tr:nth-child(even) {
        background: #fff;
    }

    tr.header {
        background: #fff !important;
        font-weight: bold;
    }

    tr.subheader {
        background: #fff !important;
        color: dimgray;
    }

    tr.headerLastRow {
        border-bottom: 2px solid black;
    }

    th.rowNumber, td.rowNumber {
        text-align: right;
    }
    """,
)

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
    IS.show_time_series_data(io, p.data; backend=:auto)
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
            #print(getter_func)
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

function show_portfolio_table(io::IO, p::Portfolio; kwargs...)
    column_labels = ["Property", "Value"]
    table = Any[
        "Name"        isnothing(get_name(p)) ? "" : get_name(p)
        "Description" isnothing(get_description(p)) ? "" : get_description(p)
        "Aggregation" string(p.aggregation)
    ]
    fd = get_financial_data(p)
    if !isnothing(fd)
        table = vcat(
            table,
            Any[
                "Base Year"     string(fd.base_year)
                "Discount Rate" string(fd.discount_rate)
            ],
        )
    end
    PrettyTables.pretty_table(
        io,
        table;
        column_labels = column_labels,
        title = "Portfolio",
        alignment = :l,
        kwargs...,
    )
    return
end

function show_technologies_table(io::IO, p::Portfolio; kwargs...)
    column_labels = ["Type", "Count"]
    components = p.data.components
    tech_types = [t for t in keys(components.data) if t <: Technology]
    isempty(tech_types) && return

    tech_type_names = [(IS.strip_module_name(x), x) for x in tech_types]
    sort!(tech_type_names; by = x -> x[1])
    tech_data = Array{Any, 2}(undef, length(tech_type_names), 2)
    for (i, (name, type)) in enumerate(tech_type_names)
        tech_data[i, 1] = name
        tech_data[i, 2] = length(components.data[type])
    end
    println(io)
    PrettyTables.pretty_table(
        io,
        tech_data;
        column_labels = column_labels,
        title = "Technologies",
        alignment = :l,
        kwargs...,
    )
    return
end

function show_region_topology_table(io::IO, p::Portfolio; kwargs...)
    column_labels = ["Type", "Count"]
    components = p.data.components
    region_types = [t for t in keys(components.data) if t <: RegionTopology]
    isempty(region_types) && return

    region_type_names = [(IS.strip_module_name(x), x) for x in region_types]
    sort!(region_type_names; by = x -> x[1])
    region_data = Array{Any, 2}(undef, length(region_type_names), 2)
    for (i, (name, type)) in enumerate(region_type_names)
        region_data[i, 1] = name
        region_data[i, 2] = length(components.data[type])
    end
    println(io)
    PrettyTables.pretty_table(
        io,
        region_data;
        column_labels = column_labels,
        title = "Topology",
        alignment = :l,
        kwargs...,
    )
    return
end
