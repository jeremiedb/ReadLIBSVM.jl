push!(LOAD_PATH, "../src/")

using Documenter
using ReadLIBSVM

pages = [
    "Introduction" => "index.md",
    "API" => "api.md",
]

makedocs(
    sitename="ReadLIBSVM.jl",
    authors="Jeremie Desgagne-Bouchard and contributors.",
    format=Documenter.HTML(
        edit_link="main",
    ),
    pages=pages,
    modules=[ReadLIBSVM]
)

deploydocs(repo="github.com/jeremiedb/ReadLIBSVM.jl.git",
    target="build",
    devbranch="main")
