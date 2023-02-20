Bootstrap: library
From: ubuntu:20.04
%help
	Container for TEFLoN2
	https://github.com/asfistonlavie/TEFLoN2
	Includes
		BWA  0.7.17
		RepeatMasker 4.1.3
		Ptyhon 3.8
		Samtools 1.16.1
		Snakemake  7.14.0
		
%labels
	VERSION "TEFLoN2 v1.0"
	Maintener Corentin Marco <corentin.marco.bioinfo@gmail.com>
	October,2022

%post
	# faster apt downloads
	export DEBIAN_FRONTEND=noninteractive
	export LC_ALL=C
	(
		. /etc/os-release
		cat << _EOF_ > mirror.txt
deb mirror://mirrors.ubuntu.com/mirrors.txt ${UBUNTU_CODENAME} main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt ${UBUNTU_CODENAME}-updates main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt ${UBUNTU_CODENAME}-backports main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt ${UBUNTU_CODENAME}-security main restricted universe multiverse

_EOF_
		mv /etc/apt/sources.list /etc/apt/sources.list.bak
		cat mirror.txt /etc/apt/sources.list.bak > /etc/apt/sources.list
	)


# apt dependencies
    apt update
    apt install -y \
    	apt-utils \
        autoconf \
        automake \
        bwa \
        cmake \
        gcc \
        build-essential \
        software-properties-common \
        tar \
        unzip \
        wget \
        zlib1g-dev \
        sudo \
        git-core \
        locales \
        python3-pip \
        ncbi-blast+ \
        bedtools \
        minimap2 \
        snakemake \
        assemblytics \
        r-base \
        perl \
        pandoc-citeproc \
        python3-h5py \
        libfontconfig1-dev \
        libxml2-dev \
        libcurl4-openssl-dev \
        libssl-dev \
        curl \
        gawk

	##samtools 1.16.1
    cd /usr/bin
	wget https://github.com/samtools/samtools/releases/download/1.16.1/samtools-1.16.1.tar.bz2
	tar -vxjf samtools-1.16.1.tar.bz2
	rm samtools-1.16.1.tar.bz2
	cd samtools-1.16.1
    make
    make install


    #RepeatMasker 4.1.3
    #Dependances

    ## Download RMBlast
    cd /usr/bin
    wget http://www.repeatmasker.org/rmblast-2.11.0+-x64-linux.tar.gz
    tar zxvf rmblast-2.11.0+-x64-linux.tar.gz


    # Download TRF
    wget https://github.com/Benson-Genomics-Lab/TRF/releases/download/v4.09.1/trf409.linux64
    # To copy binary elsewhere
    chmod +x trf409.linux64 



    ##Download and install RepeatMasker
    cd /usr/local/bin
    wget https://www.repeatmasker.org/RepeatMasker/RepeatMasker-4.1.3-p1.tar.gz
    tar -zxvf RepeatMasker-4.1.3-p1.tar.gz
    rm RepeatMasker-4.1.3-p1.tar.gz
    cd /usr/local/bin/RepeatMasker
    perl ./configure --trf_prgm=/usr/bin/trf409.linux64  --rmblast_dir=/usr/bin/rmblast-2.11.0/bin


%environment
	export LC_ALL=C

%runscript
	exec "$@"
			
