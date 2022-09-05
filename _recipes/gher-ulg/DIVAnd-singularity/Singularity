Bootstrap: docker
From: julia:1.8.0

%help
    Julia 1.8.0 with DIVAnd (run from a writable directory to create .julia-depot-singularity)


%post
    ln -s /usr/local/julia/bin/julia /usr/local/bin/julia
    apt-get -y update
    apt-get -y install curl
    apt-get -y install emacs-nox
    apt-get -y install python3-pip
    pip3 install matplotlib
    echo $HOME $JULIA_DEPOT_PATH
    export JULIA_DEPOT_PATH=/opt/julia-depot
    julia --eval 'using Pkg; pkg"add HTTP"'
    julia --eval 'using Pkg; pkg"add PhysOcean"'
    julia --eval 'using Pkg; pkg"add https://github.com/gher-ulg/OceanPlot.jl#master"'
    julia --eval 'using Pkg; pkg"add https://github.com/gher-ulg/DIVAnd.jl#Alex"'
    julia --eval 'using Pkg; pkg"add Missings"'
    julia --eval 'using Pkg; pkg"add PackageCompiler"'
    julia --eval 'using Pkg; pkg"add PyPlot Interpolations MAT"'
    julia --eval 'using Pkg; pkg"add JSON SpecialFunctions Interact Roots"'
    julia --eval 'using Pkg; pkg"add Gumbo AbstractTrees Glob NCDatasets Knet CSV"'
    julia --eval 'using Pkg; pkg"add DataStructures Compat Mustache StableRNGs"'
    julia --eval 'using Pkg; pkg"precompile"'

    # does not work with singularity 3.4.0
    #chmod -R 777 /opt
    #chmod -R 777 /usr/local/julia

%environment
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8
    export JULIA_DEPOT_PATH=/opt/julia-depot

%test
    # PATH is set but not exported on singularity 3.4.0
    export PATH
    mkdir /tmp/julia-depot-tmp
    export JULIA_DEPOT_PATH=/tmp/julia-depot-tmp:/opt/julia-depot
    # julia --eval 'using Pkg; pkg"test DIVAnd"'

%runscript
    # first depot entry must be writable
    # https://github.com/JuliaLang/Pkg.jl/pull/733#issuecomment-420811091
    # https://github.com/JuliaLang/Pkg.jl/issues/763
    export JULIA_DEPOT_PATH=$PWD/.julia-depot-singularity:/opt/julia-depot
    #export JULIA_DEPOT_PATH=/opt/julia-depot
    echo JULIA_DEPOT_PATH: $JULIA_DEPOT_PATH
    julia "$@"
