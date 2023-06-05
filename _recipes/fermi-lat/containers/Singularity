Bootstrap:docker
From:centos:6

%labels
    Maintainer "Joris Guillouf <jguillouf@lupm.in2p3.fr>"

%post
    yum update -y && yum install -y  --setopt=tsflags='' epel-release centos-release-scl-rh

    yum install -y scons \
        time \
        freetype-devel libX11-devel libXt-devel openmotif-devel \
        libXcursor-devel mesa-libGL-devel libGLU-devel \
        libXrandr-devel libtiff-devel \
        xrootd-client \
        python27

    mkdir -p /{software,afs,sps,scratch}
    mkdir -p /var/spool/sge

%files
    bin/bridge.sh /opt

%environment
    P2_SENDMAIL=/opt/bridge.sh
    export P2_SENDMAIL
    export XDG_DATA_DIRS="/opt/rh/python27/root/usr/share:/usr/local/share:/usr/share"
    export X_SCLS="python27 "
    export MANPATH="/opt/rh/python27/root/usr/share/man:"
    export PKG_CONFIG_PATH="/opt/rh/python27/root/usr/lib64/pkgconfig"
    export PATH="/opt/rh/python27/root/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
    export LD_LIBRARY_PATH="/opt/rh/httpd24/root/usr/lib64:/opt/rh/python27/root/usr/lib64"
