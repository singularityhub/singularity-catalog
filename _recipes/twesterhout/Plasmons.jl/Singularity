Bootstrap: docker
From: julia:1.5-buster

%post
    mkdir /julia
    export JULIA_DEPOT_PATH=/julia
    julia -e 'import Pkg; Pkg.update(); Pkg.add(url="https://github.com/twesterhout/Plasmons.jl"); Pkg.precompile()'

%environment
    export JULIA_DEPOT_PATH=/julia

%test
    julia -e 'import Plasmons'

%runscript
    julia -O3 -e 'import Plasmons; Plasmons.julia_main()' -- "$@"
