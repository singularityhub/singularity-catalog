Bootstrap: docker
From: ubuntu:focal

%post
    ## Install all necessary dependencies.
    apt-get update
				export DEBIAN_FRONTEND=noninteractive
				export TZ="Europe/London"
    apt-get install --no-install-recommends -y \
 																						build-essential cmake g++ make python perl \
																							bison flex ca-certificates git \
				                   coinor-libcbc-dev coinor-libclp-dev \
																							coinor-libcgl-dev libgsl-dev libfl-dev libbison-dev\
                       coinor-libcoinutils-dev zlib1g-dev libbz2-dev
    rm -rf /var/lib/apt/lists/*

    git clone https://github.com/roveri-marco/optic.git /planner

    ## Build your planner
    cd /planner
    ./run-cmake-release
				./build-release

				# Cleanup not needed packages
				apt autoremove -y --purge

%environment
    export LC_ALL=C
				export DEBIAN_FRONTEND=noninteractive
				export TZ="Europe/London"

%runscript
    ## The runscript is called whenever the container is used to solve
    ## an instance.

				# This is needed to avoid weird messages about profiling files
    # enabled by default in the compiler with optimization, so that
    # files are saved in a particular directory that then is destroyed.
				export tmpdir=/tmp/optic_$$
				export GCOV_PREFIX=${tmpdir}
    ## Call your planner.
    /planner/release/optic/optic-clp $*
				rm -rf ${tmpdir}

## Update the following fields with meta data about your submission.
## Please use the same field names and use only one line for each value.
%labels
Name        optic

Description The optic temporal planner originally taken from\
												https://sourceforge.net/projects/tsgp/files/OPTIC/ and\
												adapted to compile in recent machines in\
												https://github.com/roveri-marco/optic\
												\
												OPTIC is free software: you can redistribute it and/or\
												modify it under the terms of the GNU General Public\
												License as published by the Free Software Foundation,\
												either version 2 of the License, or (at your option) any\
												later version.\
												\
												OPTIC is distributed in the hope that it will be useful,\
												but WITHOUT ANY WARRANTY; without even the implied\
												warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR\
												PURPOSE.  See the GNU General Public License for more\
												details.\
Authors    J. Benton, A. J. Coles, A. I. Coles, K. Tierney,\
										 C. Kroer, A. Britt, R. M. Jensen, ported by Marco Roveri
SupportsDerivedPredicates no
SupportsQuantifiedPreconditions no
SupportsQuantifiedEffects no