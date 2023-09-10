module ReadLIBSVM

export read_libsvm

"""
    read_libsvm(filepath::String; has_query=false)
    read_libsvm(raw::Vector{UInt8}; has_query=false)

Read data in the LIBSVM format from either a file or a raw byte vector and return it as a tuple containing feature matrix, target labels, and optionally query entries.

# Arguments
- `filepath::String`: The path to a file containing data in LIBSVM format. Only one of `filepath` or `raw` should be provided.
- `raw::Vector{UInt8}`: A vector of raw bytes containing data in LIBSVM format. Only one of `filepath` or `raw` should be provided.
- `has_query::Bool=false`: A boolean flag indicating whether the data includes query entries.

# Returns
- A tuple `(x, y)` if `has_query` is `false`, where
    - `x::Matrix{Float64}`: The feature matrix as a dense `Float64` matrix, where each row represents a data point, and each column represents a feature.
    - `y::Vector{Float64}`: The target labels as a dense vector of `Float64`.
- A tuple `(x, y, q)` if `has_query` is `true`, where
    - `x::Matrix{Float64}`: The feature matrix as a dense `Float64` matrix.
    - `y::Vector{Float64}`: The target labels as a dense vector of `Float64`.
    - `q::Vector{Int}`: The query entries as a dense vector of `Int`.
"""
function read_libsvm(filepath::String; has_query=false)
    raw = read(filepath)
    return read_libsvm(raw; has_query) 
end

function read_libsvm(raw::Vector{UInt8}; has_query=false)

    io = IOBuffer(raw)
    lines = readlines(io)

    nobs = length(lines)
    nfeats = 0 # initialize number of features

    y = zeros(Float64, nobs)

    if has_query
        offset = 2 # offset for feature idx: y + query entries
        q = zeros(Int, nobs)
    else
        offset = 1 # offset for feature idx: y
    end

    vals = [Float64[] for _ in 1:nobs]
    feats = [Int[] for _ in 1:nobs]

    for i in eachindex(lines)
        line = lines[i]
        line_split = split(line, r"\s+(?!$)")
        y[i] = parse(Float64, line_split[1])
        has_query ? q[i] = parse(Int, split(line_split[2], ":")[2]) : nothing

        n = length(line_split) - offset
        lfeats = zeros(Int, n)
        lvals = zeros(Float64, n)
        @inbounds for jdx in 1:n
            ls = split(line_split[jdx+offset], ":")
            lvals[jdx] = parse(Float64, ls[2])
            lfeats[jdx] = parse(Int, ls[1])
            lfeats[jdx] > nfeats ? nfeats = lfeats[jdx] : nothing
        end
        vals[i] = lvals
        feats[i] = lfeats
    end

    x = zeros(Float64, nobs, nfeats)
    @inbounds for i in 1:nobs
        @inbounds for jdx in 1:length(feats[i])
            j = feats[i][jdx]
            val = vals[i][jdx]
            x[i, j] = val
        end
    end

    if has_query
        return (x=x, y=y, q=q)
    else
        return (x=x, y=y)
    end
end

end # module ReadLIBSVM
