Bootstrap: docker
From: debian:9-slim
Stage: build-singularity

%post
	set -ex

	export GO_VERSION=1.14.12 OS=linux ARCH=amd64
	export SINGULARITY_VERSION=3.8.1

	apt-get update
	apt-get install -y --no-install-recommends \
	    build-essential \
	    uuid-dev \
	    libgpgme-dev \
	    squashfs-tools \
	    libseccomp-dev \
	    wget \
	    pkg-config \
	    cryptsetup-bin \
	    ca-certificates

	wget https://dl.google.com/go/go$GO_VERSION.$OS-$ARCH.tar.gz
	tar -C /usr/local -xzf go$GO_VERSION.$OS-$ARCH.tar.gz
	rm go$GO_VERSION.$OS-$ARCH.tar.gz
	export PATH="/usr/local/go/bin:${PATH}"

	wget https://github.com/sylabs/singularity/releases/download/v${SINGULARITY_VERSION}/singularity-ce-${SINGULARITY_VERSION}.tar.gz
	tar -xzf singularity-ce-${SINGULARITY_VERSION}.tar.gz
	cd singularity-ce-${SINGULARITY_VERSION}
	./mconfig --without-suid
	make -C ./builddir
	make -C ./builddir install

Bootstrap: docker
From: debian:9-slim

%files from build-singularity
       /usr/local/bin /usr/local
       /usr/local/etc/singularity
       /usr/local/libexec/singularity
       /usr/local/etc/bash_completion.d/singularity

%post
	apt-get update
	apt-get install -y --no-install-recommends \
	    squashfs-tools \
	    libseccomp-dev \
	    ca-certificates

	apt-get clean
	rm -rf /var/lib/apt/lists/*

	mkdir -p /usr/local/var/singularity/mnt/session