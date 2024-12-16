Bootstrap: docker
From: ubuntu:19.04

%post
    apt-get -y update
    apt-get -y install fortune cowsay lolcat
    # Switching to bash as default shell since some shells scripts somewhere in our dependencies use bashisms w/ /bin/sh shebang line
    ln -s bash /bin/sh.bash
    mv /bin/sh.bash /bin/sh
    apt-get -y install python3
    apt-get -y install git-all
    apt-get -y install g++ make automake autoconf wget sox libtool subversion python2.7 zlib1g-dev
    mkdir -p /opt/shreya
    mkdir -p /opt/shreya
    cd /opt/shreya
    if [ ! -d kaldi ] ; then git clone https://github.com/kaldi-asr/kaldi.git ; fi
    cd kaldi/tools
    if [ ! -f /opt/shreya/kaldi/built-ok ] ; then extras/check_dependencies.sh ; fi
    if [ ! -f /opt/shreya/kaldi/built-ok ] ; then make -j ; fi
    if [ ! -f intel-mlk-installed ] ; then extras/install_mkl.sh && touch intel-mlk-installed ; fi
    if [ ! -f /opt/shreya/kaldi/built-ok ] ; then extras/install_irstlm.sh ; fi
    if [ ! -f /opt/shreya/kaldi/tools/openfst ] ; then make openfst ; fi
    cd ../src
    if [ ! -f /opt/shreya/kaldi/built-ok ] ; then ./configure ; fi
    if [ ! -f /opt/shreya/kaldi/built-ok ] ; then make depend -j ; fi
    if [ ! -f /opt/shreya/kaldi/built-ok ] ; then make -j ; fi
    cd /opt/shreya
    touch kaldi/built-ok
    cd /opt/shreya
    if [ -d gentle-labs ] ; then rm -r gentle-labs ; fi
    if [ ! -d gentle-labs ] ; then git clone https://github.com/shreya2111/gentle-labs.git ; fi
    if [ ! -d gentle ] ; then git clone https://github.com/lowerquality/gentle.git ; fi
    cd gentle/
    export MAKE="make -j"
    apt-get -y install gfortran
    if [ ! -f install-deps ] ; then ./install_deps.sh && touch install-deps ; fi
    if [ ! -f install-gentle ] ; then yes | ./install.sh && touch install-gentle ; fi 
    cd /opt/shreya
    rm -rf kaldi/egs/gentles
    cp -a gentle-labs/v2/gentle kaldi/egs
    cp -a gentle-labs/v2/gentle/gentle/* gentle/gentle/
    cd kaldi/egs/gentle
    # python3 scripts/initialize.py /opt/shreya/kaldi/egs/gentle/data /opt/shreya/kaldi/egs/gentle/trained_model+lexicon /opt/shreya/kaldi/egs/gentle/trained_model+lexicon/lexicon.txt
    python3 scripts/main.py /opt/shreya/kaldi/egs/gentle/initial/ru_0070.wav /opt/shreya/kaldi/egs/gentle/initial/text_70.txt /opt/shreya/kaldi /opt/shreya/gentle /opt/shreya/kaldi/egs/gentle/data /opt/shreya/kaldi/egs/gentle/trained_model+lexicon /opt/shreya/kaldi/egs/gentle/trained_model+lexicon/lexicon.txt
    echo hello > /opt/shreya/ok.txt
    
%environment
    export LC_ALL=C
    export PATH=/usr/games:$PATH

%runscript
    # fortune | cowsay | lolcat
    cat /opt/shreya/ok.txt