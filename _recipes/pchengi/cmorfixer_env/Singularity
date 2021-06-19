Bootstrap: docker
From: debian

%files
    scripts/ /opt/
    cmor_fixer/ /opt/

%post
    apt-get update && apt-get install -y git wget make libssl-dev libpython3-dev build-essential vim screen bash
    cd /opt/cmor_fixer
    export SHELL=/bin/bash
    git clone https://github.com/pchengi/cmor-fixer.git
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh -b -u -p /opt/cmor_fixer/miniconda3
    echo 'miniconda3path=/opt/cmor_fixer/miniconda3/' >>/etc/bashrc
    echo "alias activateminiconda3='source /opt/cmor_fixer/miniconda3/etc/profile.d/conda.sh'" >>/etc/bashrc
    /bin/bash -c 'source /etc/bashrc'
    /bin/bash -c 'source /opt/cmor_fixer/miniconda3/etc/profile.d/conda.sh'
    /bin/bash -c '/opt/cmor_fixer/miniconda3/bin/conda update -y -n base -c defaults conda'
    cd cmor-fixer && git checkout check-output-filename
    /bin/bash -c '/opt/cmor_fixer/miniconda3/bin/conda env create -f environment.yml'
