bootstrap:docker
from: ubuntu:20.04

%environment
 export PATH=$PATH:"/usr/local/julia-1.7.1/bin"

%runscript
  exec bash "$@"

%post
 export DEBIAN_FRONTEND=noninteractive
 export TZ=Etc/UTC
 apt-get update
 apt-get install -y software-properties-common
 apt-get install -y  build-essential \
                     git \
                     wget \
                     cmake

 apt-get clean

 # setup julia
 wget "https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.1-linux-x86_64.tar.gz" \
     -O "julia.tar.gz"
 tar -xzf "julia.tar.gz" -C "/usr/local/"
 rm "julia.tar.gz"
