

BootStrap: docker
From: centos:6

#%runscript
#    echo "This is what happens when you run the container..."

%setup
    cp gis_dependency.makefile $SINGULARITY_ROOTFS/tmp/

%post
    echo "Hello from inside the container"
    yum -y install epel-release yum-plugin-priorities

    yum -y upgrade

    yum -y groupinstall "Additional Development" \
                        "Compatibility Libraries" \
                        "Console Internet Tools" \
                        "Development Tools" \
                        "Internet Applications" \
                        "Networking Tools" \
                        "Scientific Support" 

    yum -y install tcsh wget curl rsync which time bc octave octave-devel \
                   fontconfig libxml2 openssl098e libGLU libXpm \
                   gcc libgfortran \
                   subversion git gcc-gfortran gcc-c++ binutils binutils-devel \
                   python-devel libxml2-devel mesa-libGL-devel \
                   numpy scipy \
                   glew-devel libX11-devel libXpm-devel libXft-devel libXt \
                   libXaw-devel libXext-devel libXmu-devel tk-devel tcl-devel \
                   mesa-libEGL-devel glib-devel glib2-devel gsl-devel \
                   java-1.8.0-openjdk java-1.8.0-openjdk-devel \
                   R-devel graphviz

    cd /tmp && make -f gis_dependency.makefile

    rm -rf /tmp/build-dir


