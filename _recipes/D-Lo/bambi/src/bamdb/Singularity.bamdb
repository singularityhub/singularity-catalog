Bootstrap: docker
From: ubuntu:16.04
%files
src/ /bamdb/src/
include/ /bamdb/include/
CMakeLists.txt /bamdb
%post
# Start with Ubuntu

# Get necessary libraries
apt-get update && apt-get install -y \
cmake \
make \
clang \
liblmdb-dev \
libck-dev \
libhts-dev \
libz-dev

# Copy bamdb source into container working directory
cd /bamdb

# Compile bamdb
make

# Run bamdb
%runscript
exec /bin/bash "$@"
