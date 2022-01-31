Bootstrap: docker
From: ubuntu:16.04

%setup
    export LC_ALL=C

%files
	bin/alienTrimmerPF8contaminants.fasta /home/
    bin/ExtractAnnotation.py /usr/local/bin
    bin/sum_contigs_length_per_annotation.R /usr/local/bin
    bin/cluster_to_fasta.py /usr/local/bin
    bin/fasta.py /usr/local/bin
    bin/binning_stats.R /usr/local/bin
	bin/nb_bin_per_threshold.R /usr/local/bin
	bin/binning_heatmap.R /usr/local/bin
    bin/split_abun_file.sh /usr/local/bin

%post
    #mkdir /pasteur
    chmod +x /usr/local/bin/*
    ###packages installation
    apt -y update
    apt -y install wget build-essential subread python2.7 python2.7-dev python-pip \
    camlp4-extra gawk libgsl0-dev sqlite3 libsqlite3-dev libz-dev m4 \
    ocaml patch ocaml-native-compilers opam zip gcj-jdk openmpi-bin mpich zlib1g \
    zlib1g-dev bzip2 libbz2-dev libncurses5-dev gsl-bin libblas-dev liblapack-dev \
    libboost-dev libboost-program-options-dev perl autoconf ruby zlib1g zlib1g-dev \
    libtool m4 automake libpcre3 libpcre3-dev liblzma-dev openjdk-8-jre

    ###python libraries installation
    pip install scipy==1.2.2 numpy==1.16.3 pandas==0.24.2 biopython scikit-learn==0.20 pysam bcbio-gff distribute nose cvxopt matplotlib==2.2.4 dendropy screamingbackpack sphinx==1.6.7
    pip install cogent

    ###programs installation
	cd /home


    ##filtering
    wget https://github.com/BenLangmead/bowtie2/releases/download/v2.2.9/bowtie2-2.2.9-linux-x86_64.zip
    unzip bowtie2-2.2.9-linux-x86_64.zip
    rm bowtie2-2.2.9-linux-x86_64.zip
    mv bowtie2-2.2.9/* /usr/local/bin/

    ##trimming
    wget ftp://ftp.pasteur.fr/pub/gensoft/projects/AlienTrimmer/AlienTrimmer_0.4.0.tar.gz
    tar -xzf AlienTrimmer_0.4.0.tar.gz
    rm AlienTrimmer_0.4.0.tar.gz
    cd AlienTrimmer_0.4.0/src
	sed "s:-march=native::g" -i Makefile
    make
    mv AlienTrimmer /usr/local/bin/

    ##bbmap
    cd /home
    wget -O BBMAP_38.73.tar.gz https://sourceforge.net/projects/bbmap/files/BBMap_38.73.tar.gz/download
    tar -xzf BBMAP_38.73.tar.gz

    ##khmer
    cd /home
    wget https://github.com/dib-lab/khmer/archive/v2.0.tar.gz
    tar -xzf v2.0.tar.gz
    rm v2.0.tar.gz
    pip install khmer

    ##assemblers
    wget https://github.com/ablab/spades/releases/download/v3.11.0/SPAdes-3.11.0-Linux.tar.gz
    tar -xzf SPAdes-3.11.0-Linux.tar.gz
    rm SPAdes-3.11.0-Linux.tar.gz
    #ln -s /usr/bin/python2.7 /usr/bin/python
    mv /home/SPAdes-3.11.0-Linux/bin/* /usr/local/bin
    mv /home/SPAdes-3.11.0-Linux/share/spades /usr/local/share

    wget https://github.com/voutcn/megahit/releases/download/v1.1.2/megahit_v1.1.2_LINUX_CPUONLY_x86_64-bin.tar.gz
    tar -xzf megahit_v1.1.2_LINUX_CPUONLY_x86_64-bin.tar.gz
    rm megahit_v1.1.2_LINUX_CPUONLY_x86_64-bin.tar.gz
    mv megahit_v1.1.2_LINUX_CPUONLY_x86_64-bin/* /usr/local/bin

    wget https://github.com/sebhtml/ray/archive/v2.3.1.tar.gz https://github.com/sebhtml/RayPlatform/archive/v2.0.1.tar.gz
    tar -xzf v2.0.1.tar.gz
    tar -xzf v2.3.1.tar.gz
    rm v2.0.1.tar.gz
    rm v2.3.1.tar.gz
    cd RayPlatform-2.0.1
    make PREFIX=/home/RayPlatform-2.0.1/RayPlatform
    mv libRayPlatform.a lgpl-3.0.txt AUTHORS README.md Documentation RayPlatform/
    cd /home/ray-2.3.1
    unlink RayPlatform
    ln -s /home/RayPlatform-2.0.1/RayPlatform ./RayPlatform
    make PREFIX=ray-build LDFLAGS="-lpthread"
    make install
    ln -s /home/ray-2.3.1/ray-build/Ray /usr/local/bin/Ray

    ##contigs annotation
    cd /home
    wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.2.31/ncbi-blast-2.2.31+-x64-linux.tar.gz
    tar -xzf ncbi-blast-2.2.31+-x64-linux.tar.gz
    rm ncbi-blast-2.2.31+-x64-linux.tar.gz
    mv ncbi-blast-2.2.31+/bin/* /usr/local/bin

    # wget https://cran.r-project.org/bin/linux/ubuntu/xenial/r-base-core_3.2.5-1xenial_amd64.deb
    # apt install -y ./r-base-core_3.2.5-1xenial_amd64.deb
    # rm r-base-core_3.2.5-1xenial_amd64.deb
    wget https://cran.r-project.org/bin/linux/ubuntu/xenial/r-base-core_3.4.1-2xenial0_amd64.deb
    apt -y install ./r-base-core_3.4.1-2xenial0_amd64.deb
    rm r-base-core_3.4.1-2xenial0_amd64.deb
    R --vanilla -e 'install.packages("plyr", repo="http://mirror.ibcp.fr/pub/CRAN/")'

    ##mapping count
    wget https://gitlab.pasteur.fr/aghozlan/mbma_singularity/repository/master/archive.zip
    unzip archive.zip
    rm archive.zip
    mv mbma_singularity-master-*/* /usr/local/bin

    ##samtools
    wget https://github.com/samtools/samtools/releases/download/1.3/samtools-1.3.tar.bz2
    tar -xjf samtools-1.3.tar.bz2
    cd samtools-1.3
    ./configure
    make
    make install

    ##bedtools
    cd /home
    wget https://github.com/arq5x/bedtools2/releases/download/v2.25.0/bedtools-2.25.0.tar.gz
    tar -xzf bedtools-2.25.0.tar.gz
    rm bedtools-2.25.0.tar.gz
    cd bedtools2
	make
    make install

    ##concoct cocacola
    cd /home
    wget https://github.com/BinPro/CONCOCT/archive/0.4.0.tar.gz
    tar -xzf 0.4.0.tar.gz
    cd CONCOCT-0.4.0
    make
    python setup.py install
    cp -r scripts/* /usr/local/bin

    cd /home
    wget https://www.dropbox.com/s/ciebt2y5h7pb9r2/COCACOLA-python.zip?dl=0
    unzip COCACOLA-python.zip?dl=0
    rm COCACOLA-python.zip?dl=0
    cd COCACOLA-python
    rm -r data
    sed -i '1s/^/#! \/usr\/bin\/env python\n/' cocacola.py
    chmod +x cocacola.py
    ln -s /home/COCACOLA-python/cocacola.py /usr/local/bin/cocacola.py

    ##metabat
    cd /home
    wget https://bitbucket.org/berkeleylab/metabat/downloads/metabat-static-binary-linux-x64_v2.12.1.tar.gz
    tar -xzf metabat-static-binary-linux-x64_v2.12.1.tar.gz
    rm metabat-static-binary-linux-x64_v2.12.1.tar.gz
    chmod +x metabat/*
    mv metabat/* /usr/local/bin

    ##canopy
    wget https://bitbucket.org/HeyHo/mgs-canopy-algorithm/get/d55ed1a8b825.zip
    unzip d55ed1a8b825.zip
    cd HeyHo-mgs-canopy-algorithm-d55ed1a8b825/src/
    make -f Makefile
    mv * /usr/local/bin

    ##binsanity
    wget  http://eddylab.org/software/hmmer3/3.1b2/hmmer-3.1b2-linux-intel-x86_64.tar.gz
    tar -xzf hmmer-3.1b2-linux-intel-x86_64.tar.gz
    rm hmmer-3.1b2-linux-intel-x86_64.tar.gz
    cd hmmer-3.1b2-linux-intel-x86_64
    ./configure
    make
    make install
    cd easel
    make install

	cd /home
    wget https://github.com/hyattpd/Prodigal/archive/v2.6.3.tar.gz
    tar -xzf v2.6.3.tar.gz
    rm v2.6.3.tar.gz
    cd Prodigal-2.6.3
    make install

	cd /home
    wget https://github.com/matsen/pplacer/releases/download/v1.1.alpha18/pplacer-linux-v1.1.alpha18-2-gcb55169.zip
    unzip pplacer-linux-v1.1.alpha18-2-gcb55169.zip
    rm pplacer-linux-v1.1.alpha18-2-gcb55169.zip
    cd pplacer-Linux-v1.1.alpha18-2-gcb55169
    mv guppy pplacer rppr /usr/local/bin

	cd /home
    wget https://github.com/Ecogenomics/CheckM/archive/v1.0.7.tar.gz
    tar -xzf v1.0.7.tar.gz
    rm v1.0.7.tar.gz
    cd CheckM-1.0.7
    python setup.py install
    wget https://data.ace.uq.edu.au/public/CheckM_databases/checkm_data_2015_01_16.tar.gz
    tar -xzf checkm_data_2015_01_16.tar.gz
    rm checkm_data_2015_01_16.tar.gz

    #modify the file because cannot be done with checkm setRoot
    sed -i 's/"dataRoot": ""/"dataRoot": "\/home\/CheckM-1.0.7\/"/' /usr/local/lib/python2.7/dist-packages/checkm/DATA_CONFIG

	cd /home
    wget https://github.com/edgraham/BinSanity/archive/v0.2.6.1.tar.gz
    tar -xzf v0.2.6.1.tar.gz
    cd BinSanity-0.2.6.1
    sed -i 's/README.rst/README.md/' setup.py
    python setup.py install

    ##maxbin
    cd /home
    wget -O MaxBin-2.2.3.tar.gz https://sourceforge.net/projects/maxbin2/files/MaxBin-2.2.3.tar.gz/download
    tar -xzf MaxBin-2.2.3.tar.gz
    rm MaxBin-2.2.3.tar.gz
    cd MaxBin-2.2.3/src
    make
    #install dependencies
    mkdir /home/MaxBin-2.2.3/auxiliary
    cd /home/MaxBin-2.2.3/auxiliary
    wget https://github.com/loneknightpy/idba/releases/download/1.1.2/idba-1.1.2.tar.gz
    tar -xzf idba-1.1.2.tar.gz
    rm idba-1.1.2.tar.gz
    cd idba-1.1.2
    ./configure
    make
    make install
    mv bin/idba_ud /usr/local/bin
    cd ..
    wget -O FragGeneScan1.30.tar.gz https://sourceforge.net/projects/fraggenescan/files/FragGeneScan1.30.tar.gz/download
    tar -xzf FragGeneScan1.30.tar.gz
    rm FragGeneScan1.30.tar.gz
    cd FragGeneScan1.30
    make
    make fgs
    chmod 0755 run_FragGeneScan.pl train train/*
    mv FragGeneScan hmm* run_FragGeneScan.pl run_hmm.* train util_* /usr/local/bin/
    cd /home/MaxBin-2.2.3
    #modify the setting file
    echo "[FragGeneScan] /usr/local/bin" > setting
    echo "[HMMER3] /usr/local/bin" >> setting
    echo "[IDBA_UD] /usr/local/bin" >> setting
    echo "[Bowtie2] /usr/local/bin" >> setting
    mv setting heatmap.r marker.hmm bacar_marker.hmm run_MaxBin.pl src _getmarker.pl _getabund.pl _sepReads.pl /usr/local/bin/

    ##metagen
    cd /home
    R --vanilla -e "install.packages(c('Rcpp', 'MASS', 'mixtools', 'doParallel', 'foreach', 'seqinr', 'getopt'), repo='http://cran.univ-paris1.fr/')"

    wget https://github.com/BioAlgs/MetaGen/archive/master.zip
    unzip master.zip
    rm master.zip

    ##dastool
    cd /home
    R --vanilla -e "install.packages(c('data.table', 'doMC', 'ggplot2'), repo='http://mirror.ibcp.fr/pub/CRAN/')"

    wget https://github.com/bcthomas/pullseq/archive/1.0.2.zip
    unzip 1.0.2.zip
    rm 1.0.2.zip
    cd pullseq-1.0.2
    ./bootstrap
    ./configure
    make
    make install

    wget https://github.com/cmks/DAS_Tool/archive/1.1.0.zip
    unzip 1.1.0.zip
    rm 1.1.0.zip
    cd DAS_Tool-1.1.0
    R CMD INSTALL ./package/DASTool_1.1.0.tar.gz
    unzip db.zip

    chmod +x /home/DAS_Tool-1.1.0/DAS_Tool
    ln -s /home/DAS_Tool-1.1.0/DAS_Tool /usr/local/bin/

    ##r plots
    cd /home
    wget https://cran.r-project.org/src/contrib/Archive/cowplot/cowplot_0.9.4.tar.gz
    R --vanilla -e 'install.packages("./cowplot_0.9.4.tar.gz",repo=NULL,type="source")'
