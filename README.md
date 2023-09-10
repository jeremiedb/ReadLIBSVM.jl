# ReadLIBSVM.jl

| Documentation | CI Status |
|:------------------------:|:----------------:|
| [![][docs-stable-img]][docs-stable-url] [![][docs-latest-img]][docs-latest-url] | [![][ci-img]][ci-url] |

[docs-latest-img]: https://img.shields.io/badge/docs-latest-blue.svg
[docs-latest-url]: https://jeremiedb.github.io/ReadLIBSVM.jl/dev

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://jeremiedb.github.io/ReadLIBSVM.jl/stable

[ci-img]: https://github.com/jeremiedb/ReadLIBSVM.jl/workflows/CI/badge.svg
[ci-url]: https://github.com/jeremiedb/ReadLIBSVM.jl/actions?query=workflow%3ACI+branch%3Amain


ReadLIBSVM.jl is Julia package exporting `read_libsvm` function to parse data stored in the LIBSVM format.

## Installation

Latest:

```julia-repl
julia> Pkg.add(url="https://github.com/jeremiedb/ReadLIBSVM.jl")
```

From General Registry:

```julia-repl
julia> Pkg.add("ReadLIBSVM")
```

## Usage

Two methods are supported by `read_libsvm`: 
1. A path `String` to the file to be parsed
2. A `Vector{UInt8}` containing the raw binary data (as returned by functions like `read` or returned from an API like AWS S3)

```julia
path = download("https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/multiclass/wine.scale")
data = read_libsvm(path)
```

For datasets containing a query id, use the `has_query` kwarg: 

```julia
read_libsvm(path; has_query=true)
```
