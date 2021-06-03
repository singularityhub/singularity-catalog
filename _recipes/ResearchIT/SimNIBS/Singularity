Bootstrap: docker
From: ubuntu:16.04

%post
    apt update
    apt -y install wget python2.7 python-pip qt5-default git

    export VERSION="simnibs-2.1.2-Linux64"
    export CPUS=$(lscpu -p | grep -v '#' | wc -l)

    pip install -v numpy scipy babel six>=1.3 setuptools enum34 PyOpenGl

    # install SIP
    cd /tmp
    [ ! -e "sip-4.18.1.tar.gz" ] && wget https://sourceforge.net/projects/pyqt/files/sip/sip-4.18.1/sip-4.18.1.tar.gz
    tar -xvf sip-4.18.1.tar.gz
    cd sip-4.18.1
    python configure.py
    make -j$CPUS
    make install

    # python-qt5 is broken through pip, we have to build from source
    cd /tmp
    [ ! -e "PyQt5_gpl-5.6.tar.gz" ] && wget https://sourceforge.net/projects/pyqt/files/PyQt5/PyQt-5.6/PyQt5_gpl-5.6.tar.gz
    tar -xvf PyQt5_gpl-5.6.tar.gz
    cd PyQt5_gpl-5.6
    yes yes | python configure.py --qmake /usr/bin/qmake --sip-incdir /tmp/sip-4.18.1/siplib
    ln -sf /usr/include/python2.7 /usr/local/include/python2.7
    make -j$CPUS
    make install

    # simNIBS should be placed in the /tmp directory
    tar -C /usr/lib -xvf /tmp/${VERSION}.tar.gz
    cd /usr/lib/${VERSION}

    # install python modules
    cd Python_modules/src
    python setup.py install

    # link main scripts
    cd /usr/lib/${VERSION}/Python_modules

    for s in *.py; do
        echo "#!/bin/sh" > /usr/bin/${s%.*}
        echo "exec python /usr/lib/${VERSION}/Python_modules/$s" >> /usr/bin/${s%.*}
        chmod +x /usr/bin/${s%.*}
    done
