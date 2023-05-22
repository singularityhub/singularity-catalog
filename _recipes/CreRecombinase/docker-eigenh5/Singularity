Bootstrap: docker
From: rocker/geospatial


%post	
    mkdir -p .R
    echo "CXX17FLAGS= $(CXX17FLAGS) -Wno-ignored-attributes -DEIGEN_PERMANENTLY_DISABLE_STUPID_WARNINGS=1 -Wno-deprecated-declarations" > .R/Makevars
    installGithub.r --deps TRUE	CreRecombinase/EigenH5@chunkreader
