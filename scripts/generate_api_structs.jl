using PowerSystemsInvestmentsPortfolios
using OpenAPI
using JSON3
using JSONSchema

function read_json_data(filename::String)
    try
        return JSONSchema.Schema(JSON3.read(filename))
    catch
        throw(DataFormatError("$filename has invalid format"))
    end
end


spec = read_json_data("C:/Users/jpotts/Documents/psip_dev/SiennaInvestSchema_openapi2.json")

OpenAPI.openapi_generator()

path = OpenAPI.generate(spec.data; output_dir="C:/Users/jpotts/Documents/psip_dev/generated_code")

OpenAPI.stop_openapi_generator()

@__DIR__