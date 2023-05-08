BootStrap: debootstrap
OSVersion: bionic
MirrorURL: http://us.archive.ubuntu.com/ubuntu/

%help
    Recapitulating Titus' Kmer counting publication


%setup
    set -eu
    sed -i 's/$/ universe/' /etc/apt/sources.list
    apt-get update
    git clone https://github.com/ngs-docs/ngs-scripts
    git clone https://github.com/ged-lab/2013-khmer-counting.git
    cd 2013-khmer-counting
    curl -O http://public.ged.msu.edu.s3.amazonaws.com/2013-khmer-counting/2013-khmer-counting-data.tar.gz
    tar xzf 2013-khmer-counting-data.tar.gz
    cd pipeline
    bash software_install.sh
    apt-get clean
    rm -rf /var/lib/apt/lists/*


%post
    cd ~/2013-khmer-counting/pipeline
    bash software_install.sh
    mkdir ~/2013-khmer-counting/src/
    mkdir ~/2013-khmer-counting/data/
    make KHMER=~/2013-khmer-counting/src/khmer
    make copydata
        
    

#%runscript
    echo "Run the following commands:"
    echo "cd ../notebook"
    echo "ipython notebook --no-browser --ip=* --port=80 &"
    echo "cd ../"
    echo "make"
    /bin/bash



