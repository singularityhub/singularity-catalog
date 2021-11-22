# MIT License
# 
# Copyright (c) 2020-2021 Genome Research Ltd.
# 
# Author: Eerik Aunin (ea10@sanger.ac.uk)
# 
# This file is a part of the Genome Decomposition Analysis (GDA) pipeline.
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

Bootstrap: docker
From: ubuntu:20.04

%labels
  Maintainer ea10@sanger.ac.uk

%files
    feature_extraction /feature_extraction

%post
    rm -vf /var/lib/apt/lists/* && apt-get -y update && apt-get -y install build-essential parallel wget default-jre-headless git cmake g++
    
    apt-get -y -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update conda \
    && conda clean --all --yes

    conda config --add channels conda-forge
    conda config --add channels bioconda
    conda config --add channels biocore
    conda config --add channels r
    conda config --add channels anaconda
    conda config --add channels jmcmurray

    conda install -y parallel=20201122 repeatmodeler=2.0.1 diamond=2.0.4 perl-bioperl=1.7.2 pandas=1.1.3 emboss=6.6.0 hisat2=2.2.1 r-base=3.6.3 r-gplots=3.0.1.1 r-ggplot2=3.1.1 trnascan-se=2.0.6 blast=2.10.1 augustus=3.3.3 minimap2=2.17 samtools=1.10 wgsim=1.0 barrnap=0.9 gffread=0.12.1 mcl=14.137 nextflow=0.30.1 trf=4.09.1 openjdk=8.0.152 mafft=7.475 hmmer=3.3.2 umap-learn=0.4.6 hdbscan=0.8.27 matplotlib=3.3.4 json=0.1.1 numba=0.51.2 spectra=0.0.11 statsmodels=0.12.2 scipy=1.6.2 biopython=1.78 kcounter=0.1.0 liftoff=1.6.1 bedtools=2.30.0 gcc_linux-64=9.3.0 gxx_linux-64=9.3.0 gfortran_linux-64=9.3.0
    
    #r-shiny=1.1.0 r-rjson=0.2.20 r-reshape2=1.4.3 r-gridextra=2.3 r-scales=1.0.0 r-svglite=1.2.3

    mkdir -p /gda_downloads
    mkdir -p /gda_downloads/orthomcl

    wget http://www.orthomcl.org/common/downloads/software/unsupported/v1.4/ORTHOMCL_V1.4_mcl-02-063.tar -O /gda_downloads/orthomcl/omcl.tar


    cd /gda_downloads/orthomcl && \
        tar -xvf omcl.tar && \
        tar -xzvf mcl-02-063.tar.gz && \
        rm -f omcl.tar mcl-02-063.tar.gz && \
        cd /gda_downloads/orthomcl/mcl-* && \
        ./configure && \
        make -j3 && \
        make install
        

    sed -i 's/our .PATH_TO_ORTHOMCL.*=.*/our $PATH_TO_ORTHOMCL = ".\/";/' /gda_downloads/orthomcl/ORTHOMCLV1.4/orthomcl_module.pm && \
        sed -i 's/our .BLASTALL.*=.*/our $BLASTALL = "\/usr\/bin\/blastall";/' /gda_downloads/orthomcl/ORTHOMCLV1.4/orthomcl_module.pm && \
        sed -i 's/our .FORMATDB.*=.*/our $FORMATDB = "\/usr\/bin\/formatdb";/' /gda_downloads/orthomcl/ORTHOMCLV1.4/orthomcl_module.pm && \
        sed -i 's/\/Users\/fengchen\/mcl-02-063\/shmcl\/mcl/\/usr\/local\/bin\/mcl/g' /gda_downloads/orthomcl/ORTHOMCLV1.4/orthomcl_module.pm


    cd /gda_downloads/orthomcl && wget https://cpan.metacpan.org/authors/id/C/CJ/CJFIELDS/BioPerl-1.7.7.tar.gz && tar -xzvf BioPerl-1.7.7.tar.gz && rm BioPerl-1.7.7.tar.gz

    cd /gda_downloads && git clone https://github.com/BioinformaticsToolsmith/MeShClust2.git && cd MeShClust2 && cd src && mkdir bin && cmake .. && make

    mkdir -p /gda_downloads/dfam_hmm
    cd /gda_downloads/dfam_hmm && wget https://www.dfam.org/releases/Dfam_3.3/infrastructure/dfamscan/Dfam.hmm && \
        wget https://www.dfam.org/releases/Dfam_3.3/infrastructure/dfamscan/Dfam.hmm.h3f && \
        wget https://www.dfam.org/releases/Dfam_3.3/infrastructure/dfamscan/Dfam.hmm.h3i && \
        wget https://www.dfam.org/releases/Dfam_3.3/infrastructure/dfamscan/Dfam.hmm.h3m && \
        wget https://www.dfam.org/releases/Dfam_3.3/infrastructure/dfamscan/Dfam.hmm.h3p


%environment
    export LC_ALL=C
    export PATH=/opt/conda/bin:$PATH
    export PATH=/feature_extraction:$PATH
    
    export PATH=/feature_extraction/orthomcl:$PATH
    export PATH=/feature_extraction/third_party_files:$PATH
    export PATH=/feature_extraction/annotation:$PATH
    export PATH=/feature_extraction/tandem_repeats_finder:$PATH
    export PATH=/feature_extraction/repeatmodeler:$PATH
    export PATH=/feature_extraction/cpp/bin:$PATH
    export PATH=/gda_downloads/orthomcl/ORTHOMCLV1.4:$PATH
    export PATH=/gda_downloads/MeShClust2/bin:$PATH
    export PATH=/:$PATH
    export PERL5LIB=/gda_downloads/orthomcl/ORTHOMCLV1.4:$PERL5LIB
    export PERL5LIB=/gda_downloads/orthomcl/BioPerl-1.7.7/lib:$PERL5LIB
    export GDA_DOWNLOADS_FOLDER=/gda_downloads
    
