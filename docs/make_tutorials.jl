using Literate

const TUTORIALS_SRC = joinpath(@__DIR__, "src", "tutorials")
const TUTORIALS_OUT = joinpath(@__DIR__, "src", "tutorials")

function insert_md(content)
    return content
end

function clean_old_generated_files(dir::String)
    isdir(dir) || return
    for file in filter(f -> startswith(f, "generated_") && endswith(f, ".md"), readdir(dir))
        rm(joinpath(dir, file), force=true)
        @info "Removed old generated file: $file"
    end
end

function make_tutorials()
    isdir(TUTORIALS_SRC) || return Any[]
    tutorial_pages = Any[]

    clean_old_generated_files(TUTORIALS_OUT)

    for file in filter(f -> endswith(f, ".jl"), readdir(TUTORIALS_SRC))
        infile = joinpath(TUTORIALS_SRC, file)
        execute = occursin("# EXECUTE = TRUE", readline(infile))
        outname = "generated_" * replace(file, ".jl" => "")

        Literate.markdown(
            infile,
            TUTORIALS_OUT;
            name=outname,
            credit=false,
            flavor=Literate.DocumenterFlavor(),
            documenter=true,
            postprocess=insert_md,
            execute=execute,
        )

        title = titlecase(replace(replace(file, ".jl" => ""), "_" => " "))
        push!(tutorial_pages, title => joinpath("tutorials", "$(outname).md"))
    end

    return tutorial_pages
end
