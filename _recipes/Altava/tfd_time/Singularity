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
																							python2
    rm -rf /var/lib/apt/lists/*

				# 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
    git clone https://github.com/roveri-marco/tfd.git /planner

    ## Build your planner
    cd /planner
    ./build

				# Cleanup not needed packages
				apt autoremove -y --purge

%environment
    export LC_ALL=C
				export DEBIAN_FRONTEND=noninteractive
				export TZ="Europe/London"

%runscript
    ## The runscript is called whenever the container is used to solve
    ## an instance.
				export tmpdir=/tmp/optic_$$
				export TFD_HOME=/planner/downward
				mkdir -p ${tmpdir}
				python2.7 $TFD_HOME/translate/translate.py $*
				mv output.sas variables.groups all.groups ${tmpdir}
				cd ${tmpdir}
				$TFD_HOME/preprocess/preprocess < output.sas
				#                       y Y                e r O 1 C 1 b
				# ANYTIMEOPTS="a T 10 t 5"
				$TFD_HOME/search/search y Y ${ANYTIMEOPTS} e r O 1 C 1 b p ./output_plan < output
				cat output_plan*
				rm -rf ${tmpdir}

## Update the following fields with meta data about your submission.
## Please use the same field names and use only one line for each value.
%labels
Name        tfd

Description The tfd temporal planner originally taken from\
												http://gki.informatik.uni-freiburg.de/tools/tfd/downloads.html and\
												adapted to compile in recent machines in\
												https://github.com/roveri-marco/tfd\
												\
            TFD is free software; you can redistribute it and/or
            modify it under the terms of the GNU General Public
            License as published by the Free Software Foundation;
            either version 2 of the License, or (at your option) any
            later version.
												\
												TFD is distributed in the hope that it will be useful, but
												WITHOUT ANY WARRANTY; without even the implied warranty of
												MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
												the GNU General Public License for more details.
												\
												You should have received a copy of the GNU General Public
												License along with this program; if not, write to the Free
												Software Foundation, Inc., 51 Franklin Street, Fifth
												Floor, Boston, MA 02110-1301 USA.

Authors     Gabriele Röger, Patrick Eyerich, Christian Dornhege, and
            Robert Mattmüller, ported by Marco Roveri

SupportsDerivedPredicates no
SupportsQuantifiedPreconditions no
SupportsQuantifiedEffects no