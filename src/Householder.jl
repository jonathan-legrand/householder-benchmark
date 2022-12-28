module Householder
export experiment, get_and_plot_results

using LinearAlgebra, DataFrames, StatsPlots

struct Expparams
    nmin::Int
    nmax::Int
    step::Int
    nsamples::Int

    # It might be bad practice to use
    # the function as a field type. Sorry.
    gettimesfunc::Function
end
include("computing.jl")
include("gettimes.jl")
global funcmapping = Dict("vectors" => vect_gettimes, "matrices" => mat_gettimes)

function experiment(p::Expparams)
    df = DataFrame(
                   n = Int32[],
                   timplicit = Float64[],
                   texplicit = Float64[]
                  )

    # Iterate for all vector sizes
    for n in p.nmin : p.step : p.nmax

        # Compute mean execution times for implicit and explicit
        # multiplication
        multimes = zeros(1, 2)
        for _ in range(1, p.nsamples)
            timplicit, texplicit = p.gettimesfunc(n)
            multimes += [timplicit texplicit] 
        end
        multimes = multimes ./ p.nsamples

        push!(df, (n, multimes[1], multimes[2]))
    end
    return df
end

function get_and_plot_results(
        ;nmin=10::Int,
        nmax=100::Int,
        step=10::Int,
        nsamples=10::Int,
        exptype="vectors"::String,
        saveplot=false::Bool
    )
    expparams = Expparams(nmin, nmax, step, nsamples, funcmapping[exptype])
    times = experiment(expparams)
    l = names(times)
    l = l[2:end]
    @df times plot(
                   :n,
                   [:timplicit, :texplicit],
                   labels=permutedims(l),
                   markershape=:auto,
                   title="Householder matrix multiplication for $exptype",
                   ylabel="time (s)",
                   xlabel="$exptype size"
                  )
    gui()
    if saveplot
        savefig("latex-$exptype-$nmin-$nmax-$step-$nsamples.png")
    end
end

end # module
