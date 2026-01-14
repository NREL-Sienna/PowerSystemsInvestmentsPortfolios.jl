using Documenter, PowerSystemsInvestmentsPortfolios

pages = OrderedDict(
    "Welcome Page" => "index.md",
    "Quick Start Guide" => "quick_start_guide.md",
    "Tutorials" => "tutorials/intro_page.md",
    "Public API Reference" => "api/public.md",
    "Internal API Reference" => "api/internal.md",
)

makedocs(
    modules=[PowerSystemsInvestmentsPortfolios],
    format=Documenter.HTML(prettyurls=haskey(ENV, "GITHUB_ACTIONS")),
    sitename="PowerSystemsInvestmentsPortfolios.jl",
    authors="Jose Daniel Lara and Contributors",
    pages=Any[p for p in pages],
)

deploydocs(
    repo="github.com/NREL-Sienna/PowerSystemsInvestmentsPortfolios.git",
    target="build",
    branch="gh-pages",
    devbranch="main",
    devurl="dev",
    push_preview=true,
    versions=["stable" => "v^", "v#.#"],
)
