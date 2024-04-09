function Base.show(io::IO, ::MIME"text/plain", p::Portfolio)
    show_portfolio_table(io, p; backend=Val(:auto))
    println(io)
    return
end

function Base.show(io::IO, ::MIME"text/html", p::Portfolio)
    show_portfolio_table(io, p; backend=Val(:html), standalone=false)
    println(io)
    return
end

function show_portfolio_table(io::IO, p::Portfolio; kwargs...)
    header = ["Property", "Value"]
    table = [
        "Name" isnothing(get_name(p)) ? "" : get_name(p)
        "Description" isnothing(get_description(p)) ? "" : get_description(p)
        "Aggregation" string(p.aggregation)
        "Discount Rate" string(p.discount_rate)
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
