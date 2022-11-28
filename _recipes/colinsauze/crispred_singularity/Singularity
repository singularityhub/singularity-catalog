Bootstrap:docker
From:ubuntu:18.04

%help
    Container for the Redux pipeline

%labels
    MAINTAINER Colin Sauze

%environment
    #define environment variables here
    
%post  
    #setup system libraries
    apt-get update
    apt -y install build-essential git cmake wget curl autoconf 
    apt -y install libboost-all-dev libopencv-dev libcfitsio-dev libfftw3-dev libz-dev lsb-core  libz-dev libgsl-dev python-numpy libopencv-*-dev
    apt -y install vim nano mc emacs
    apt -y install gnudatalanguage astro-gdl gdl-astrolib gdl-coyote
    alias idl=gdl

    mkdir /opt/crispred
    cd /opt/crispred/


    mkdir -p idl/bin
    
    #crispred library 
    cd /opt/crispred/idl/bin/
    git clone  git://dubshen.astro.su.se/jaime/crispred
    cd crispred/creduc
    make
    
    export IDL_PATH="+/opt/crispred/idl/bin/crispred:+/opt/crispred/idl/bin/markwardt/mpfit:+/opt/crispred/idl/bin/coyote:+/opt/crispred/idl/bin/IDLAstro:$/opt/crispred/idl/bin"

    #IDL Astro
    cd /opt/crispred/idl/bin
    git clone git://github.com/wlandsman/IDLAstro.git

    #Coyote Library
    cd /opt/crispred/idl/bin
    git clone https://github.com/idl-coyote/coyote
    

    #mpfit 
    #is this required? gdl-mpfit is available as a system package
    cd /opt/crispred/idl/bin
    mkdir mpfit
    cd mpfit/
    wget http://www.physics.wisc.edu/~craigm/idl/down/mpfit.tar.gz
    tar xvfz mpfit.tar.gz

    #DLMs
    cd /opt/crispred/
    mkdir src
    cd src
    git clone git://dubshen.astro.su.se/hillberg/redux
    mkdir -p redux/build
    cd redux/build
    cmake ../ -DIDL_DLM_DIR:STRING=/opt/crispred/idl/dlm/x86_64/
    cd src/dlm
    make install 

    #bezier interpolation routines
    cd /opt/crispred/idl/bin/crispred
    #nano compile_linux.sh
    #./compile_linux.sh

    export IDL_DLM_PATH='$IDL_DLM_PATH:+/opt/crispred/idl/dlm/x86_64/'



#     git clone git://dubshen.astro.su.se/noort/momfbd
#     cd momfbd/
# 
#     aclocal
#     autoconf
#     ./configure 
#     make
#     cd ..
# 
#     git clone https://github.com/tvwerkhoven/pyana
#     cd pyana/
# 
# 
#     python pyana/pyana.py 
# 
#     python setup.py install
# 
# 
#     cd
#     wget https://idlastro.gsfc.nasa.gov/ftp/astron.zip
#     wget https://idlastro.gsfc.nasa.gov/ftp/astron.tar.gz
#     wget https://idlastro.gsfc.nasa.gov/ftp/coyote_astron.tar.gz
#     tar tvfz coyote_astron.tar.gz 
# 
#     unzip -l astron.zip 
# 
#     tar tvfz astron.tar.gz 

  

