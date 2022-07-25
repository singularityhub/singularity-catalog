Bootstrap: docker
From: ubuntu:16.04

%environment
SHELL=/bin/bash
PATH=/opt/anaconda/bin:${PATH}
LC_ALL=C.UTF-8
ROOTSYS=/opt/root/
LD_LIBRARY_PATH=/opt/root/lib


%runscript
    echo "This is what happens when you run the container..."
    export PATH=/opt/anaconda/bin:${PATH}

%post
    echo "Hello from inside the container"
    apt-get update
    apt-get -y install wget git bzip2 build-essential gcc zlib1g-dev language-pack-en-base apt-transport-https make cmake unzip libncurses5-dev libncursesw5-dev
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

    cd /root/ && wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
    cd /root/ && chmod 700 ./Miniconda2-latest-Linux-x86_64.sh
    cd /root/ && bash ./Miniconda2-latest-Linux-x86_64.sh -b -p /opt/anaconda/   

    export PATH=/opt/anaconda/bin:${PATH} 
    pip install pysam
    pip install numpy
    pip install matplotlib
    pip install matplotlib-venn
    pip install pybedtools
    
    conda update -n base -c defaults conda
    conda config --add channels defaults
    conda config --add channels conda-forge
    conda config --add channels bioconda
    
    #VEP
    conda install -c bioconda ensembl-vep
    conda install -c bioconda/label/cf201901 ensembl-vep
    
    module load bioinfo-tools samtools/0.1.19
    module load bioinfo-tools bcftools
    module load bioinfo-tools BEDTools
    
    #retroseq
    perl /proj/nobackup/sens2017106/wharf/kbilgrav/kbilgrav-sens2017106/RetroSeq/bin/retroseq.pl -discover -bam $1  -output $2.output.vcf  -refTEs /proj/nobackup/sens2017106/test_retroseq/RetroSeq/repeatElement.tab
    perl /proj/nobackup/sens2017106/wharf/kbilgrav/kbilgrav-sens2017106/RetroSeq/bin/retroseq.pl  -call -bam $1  -input $2.output.vcf  -ref /proj/sens2017106/reference_material/fasta/human_g1k_v37.fasta  -output $2.final.vcf


 
