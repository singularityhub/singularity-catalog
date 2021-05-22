# Generate the Singularity container to run PrimerFinder on Kive.
Bootstrap: docker
From: centos:7

%help
    Search proviral consensus sequences for primers, then use HIVSeqinR to
    decide if the genomes are complete.

    This Singularity container can be run on Kive: http://cfe-lab.github.io/Kive


%labels
    MAINTAINER BC CfE in HIV/AIDS https://github.com/cfe-lab/
    KIVE_INPUTS sample_info_csv contigs_csv conseqs_csv cascade_csv
    KIVE_OUTPUTS outcome_summary_csv conseqs_primers_csv contigs_primers_csv \
        table_precursor_csv hivseqinr_results_tar
    KIVE_THREADS 1
    KIVE_MEMORY 6000

%files
    setup.py /opt/primer_finder/
    gene_splicer /opt/primer_finder/

%post
    echo ===== Installing Prerequisites ===== >/dev/null
    yum update -q -y

    yum groupinstall -q -y 'development tools'
    yum install -q -y epel-release
    yum install -q -y unzip wget fontconfig bzip2-devel xz-devel openssl-devel libffi-devel

    echo ===== Installing Python ===== >/dev/null
    wget -q https://www.python.org/ftp/python/3.8.3/Python-3.8.3.tar.xz
    tar xJf Python*
    rm Python*.xz
    cd Python*
    ./configure --enable-optimizations
    make altinstall
    cd ..
    rm -rf Python*
    ln -s /usr/local/bin/python3.8 /usr/local/bin/python3

    echo ===== Installing blast ===== >/dev/null
    cd /root
    # Saved our own copy, because download was slow from ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.6.0/ncbi-blast-2.6.0+-1.x86_64.rpm
    wget https://github.com/cfe-lab/MiCall/releases/download/v7.12.dev28/ncbi-blast-2.6.0+-1.x86_64.rpm
    yum install -q -y ncbi-blast-2.6.0+-1.x86_64.rpm
    rm ncbi-blast-2.6.0+-1.x86_64.rpm

    echo ===== Installing Python packages ===== >/dev/null
    wget -q https://bootstrap.pypa.io/get-pip.py
    python3 get-pip.py
    rm get-pip.py
    cd /opt/primer_finder
    pip install .

    # Note that yum installs need to happen before the alternatives command is run, yum will not work with Python3
    echo ===== Installing R ===== >/dev/null
    # Shouldn't need this since it was installed earlier
    # yum install epel-release -y
    yum install R -y
    Rscript /opt/primer_finder/gene_splicer/configure_r.sh 2> /dev/null

    echo ===== Installing minimap2 ===== >/dev/null
    cd /opt
    wget https://github.com/lh3/minimap2/releases/download/v2.17/minimap2-2.17_x64-linux.tar.bz2
    tar -jxvf ./minimap2-2.17_x64-linux.tar.bz2
    ln -s /opt/minimap2-2.17_x64-linux/minimap2 /bin
    rm minimap2-2.17_x64-linux.tar.bz2

    echo ===== Installing HIVSeqinR ===== >/dev/null
    python3 -m gene_splicer.hivseqinr /opt/hivseqinr

    # Clean up
    yum --setopt=groupremove_leaf_only=1 groupremove -q -y 'development tools'
    yum remove -q -y epel-release wget git
    yum autoremove -q -y
    yum clean all
    rm -rf /var/cache/yum

    ## CAUTION! This changes the default python command to python3!
    ## This breaks many things, including yum!
    ## To switch back to python2, use this command:
    # sudo alternatives --set python /usr/bin/python2
    alternatives --install /usr/bin/python python /usr/bin/python2 50
    alternatives --install /usr/bin/python python /usr/local/bin/python3 60

%environment
    export LANG=en_US.UTF-8

%runscript
    gene_splicer_sample --hivseqinr /opt/hivseqinr "$@"
