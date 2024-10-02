using PowerSystemsInvestmentsPortfolios
using JSON3
const PSIP = PowerSystemsInvestmentsPortfolios

function generate_config(schema_file)
    """Generate validation descriptors from the PSIP OpenAPI specification file."""


    schema = read_json_data(schema_file)
    data = schema.data
    @show data
    items = []

    #return data
    for data_struct in data["x-\$defs"]
        #return data_struct
        new_struct = Dict()
        new_struct["name"] = data_struct.first
        if haskey(data_struct.second, "parametric")
            new_struct["parametric"] = data_struct.second["parametric"]
        end
        new_struct["fields"] = []
        for field in data_struct.second["properties"]
            new_field = Dict()
            new_field["name"] = field.first

            if "type" in keys(field.second) new_field["type"] = field.second["type"] end
            if "default" in keys(field.second) new_field["default"] = field.second["default"] end

            push!(new_struct["fields"], new_field)

        end
        
        push!(items, new_struct)
    end

    return Dict("auto_generated_structs" => items)
    
end


function generate_file(output_file, input_file)
    """Generate validation descriptors from the PowerSystems struct data file."""
    config = generate_config(input_file)

    open(output_file, "w") do io
        JSON3.pretty(io, config)
    end

end

generate_file("src/descriptors/portfolio_structs.json", "C:/Users/jpotts/Documents/SiennaInvestSchema_openapi.json")