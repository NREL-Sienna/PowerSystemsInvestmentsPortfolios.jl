function validate_serialization(
    port::Portfolio;
    time_series_read_only=false,
    runchecks=nothing,
    assign_new_uuids=false,
)
    test_dir = mktempdir()
    orig_dir = pwd()
    cd(test_dir)

    try
        path = joinpath(test_dir, "test_portfolio_serialization.json")
        @info "Serializing to $path"
        port_ext = PSIP.get_ext(port)
        port_ext["data"] = 5

        PSIP.to_json(port, path; force=true)

        data = open(path, "r") do io
            JSON3.read(io)
        end
        @test data["data_format_version"] == PSIP.DATA_FORMAT_VERSION

        port2 = Portfolio(path)

        isnothing(get_financial_data(port2)) && return false
        port_ext2 = PSIP.get_ext(port2)
        port_ext2["data"] != 5 && return false

        #return port2, IS.compare_values(port, port2; compare_uuids = false)
        return port2
    finally
        cd(orig_dir)
    end
end
