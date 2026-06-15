using InteractiveUtils
import InfrastructureSystems as IS

function _clean_old_generated_files(dir::String)
    if !isdir(dir)
        @warn "Directory does not exist: $dir"
        return
    end
    for file in filter(f -> startswith(f, "generated_") && endswith(f, ".md"), readdir(dir))
        rm(joinpath(dir, file), force=true)
        @info "Removed old generated file: $file"
    end
end

function _check_exception(T, exceptions::Vector)
    for exc in exceptions
        T <: exc && return true
    end
    return false
end

function _write_generated_page(c::String)
    file_name = "model_library/generated_$(c).md"
    open(joinpath("docs/src", file_name), "w") do io
        print(
            io,
            """
            # $(c)

            ```@autodocs
            Modules = [PowerSystemsInvestmentsPortfolios]
            Pages   = ["generated/$(c).jl"]
            Order = [:type, :function]
            Public = true
            Private = false
            ```
            """,
        )
    end
    return file_name
end

function make_model_library(;
    categories=[],
    exceptions=[],
    manual_additions=Dict{String, Any}(),
)
    outdir = joinpath("docs", "src", "model_library")
    isdir(outdir) || mkpath(outdir)
    _clean_old_generated_files(outdir)

    model_library = Dict{String, Any}()

    for abstract_type in categories
        @info "Making model library entries for subtypes of $abstract_type"
        internal_index = Any[]
        for c_ in IS.get_all_concrete_subtypes(abstract_type)
            _check_exception(c_, exceptions) && continue
            c = string(nameof(c_))
            file_name = _write_generated_page(c)
            push!(internal_index, c => file_name)
        end
        isempty(internal_index) && continue
        model_library[string(nameof(abstract_type))] = internal_index
    end

    for (k, v) in manual_additions
        if haskey(model_library, k)
            append!(model_library[k], v)
        else
            model_library[k] = collect(v)
        end
    end

    return Any[p for p in model_library]
end
