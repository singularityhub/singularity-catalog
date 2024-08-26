Bootstrap:docker
From:nvidia/cuda:11.2.2-devel-ubuntu20.04

%labels
MAINTAINER Thomas Green

%environment
  PATH=$PATH:/opt/mumax3/bin

%runscript
exec /bin/bash /bin/echo "Not supported"

%post
mkdir /scratch
mkdir /software
mkdir /apps
mkdir /app


DEBIAN_FRONTEND=noninteractive apt-get update -yy
DEBIAN_FRONTEND=noninteractive apt-get install -yy --no-install-recommends wget
DEBIAN_FRONTEND=noninteractive apt-get install -yy --no-install-recommends build-essential make cmake gcc g++ git gnuplot-nox

# Install go
cd /tmp
wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
rm /tmp/go1.21.6.linux-amd64.tar.gz

# Clean apt directories
apt-get clean
rm -rf /var/lib/apt/lists/*

# Set install location
mkdir /opt/mumax3
export GOPATH=/opt/mumax3
go install github.com/mumax/3/cmd/mumax3@master
go install github.com/mumax/3/cmd/mumax3-server@master
go install github.com/mumax/3/cmd/mumax3-plot@master
go install github.com/mumax/3/cmd/mumax3-convert@master




