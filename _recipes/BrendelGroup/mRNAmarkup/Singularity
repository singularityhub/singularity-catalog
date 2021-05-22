bootstrap: docker
From: fedora:34

%post
    dnf -y update
    dnf -y install bc diffutils git tcsh tzdata unzip zip wget which bzip2
    dnf -y install gcc gcc-c++ gcc-gfortran make autoconf automake

    dnf -y install perl-App-cpanminus
    cpanm ExtUtils::MakeMaker


    echo 'mRNAmarkup '
    cd /opt
    git clone https://github.com/BrendelGroup/mRNAmarkup
    cd mRNAmarkup/src/contributed
    ./xinstall
    cd ..
    make
    sudo make install
    make clean


%labels
    Maintainer vpbrendel
    Version v1.1.0
