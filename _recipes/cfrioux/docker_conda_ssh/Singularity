
Bootstrap: docker
From: ibmjava:latest

%labels
    Maintainer Frioux C.
    Version v0.0.1
    Description cplex, conda and cobrapy Singularity recipe

%files
    /home/clemence/cfrioux/DownloadDirector/cplex_studio2210.linux_x86_64.bin /opt/

%environment
    export PATH=$PATH:/opt/miniconda/bin/:/opt/ibm/java/jre/bin/
    export PYTHONIOENCODING=utf8
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8

%post
    ls $SINGULARITY_CONTAINER/opt/
    apt-get update && \
    apt-get install bzip2 build-essential zlib1g-dev git -qqy && \
    apt-get clean && apt-get purge

    mkdir -p /programs/ibm;\

    # install conda # && rm Miniconda3-3.7.0-Linux-x86_64.sh
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
    bash ~/miniconda.sh -b -p /opt/miniconda
    PATH="/opt/miniconda/bin:$PATH"
    conda update conda
    chmod +x $SINGULARITY_CONTAINER/opt/cplex_studio2210.linux_x86_64.bin;\
    # printf '4\n\n1\n\n\n\n\n' | . $SINGULARITY_CONTAINER/opt/cplex_studio2210.linux_x86_64.bin
    printf '4\n\n1\n/programs/ibm\nO\n\n\n\n2\n\n' | bash $SINGULARITY_CONTAINER/opt/cplex_studio2210.linux_x86_64.bin
    pip install cobrapy
    python $SINGULARITY_CONTAINER/programs/ibm/python/setup.py install
    rm $SINGULARITY_CONTAINER/programs/cplex_studio2210.linux_x86_64.bin
