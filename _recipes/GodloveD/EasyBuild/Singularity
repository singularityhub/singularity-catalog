BootStrap: docker
From: centos

%post
    # install missing dependancies                                            
    yum update -y
    yum install -y wget
    wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
    rpm -Uvh epel-release-7-9.noarch.rpm 
    yum update -y                                                            
    yum install -y unzip bzip2 patch mlocate tcl tcl-devel lua lua-posix lua-filesystem lua-devel python-pip libibverbs-dev libibverbs-devel which
    yum groupinstall -y 'Development Tools'
    pip install setuptools GitPython python-graph-dot graphviz
                                                                                    
    # install lmod                                                                  
    wget https://downloads.sourceforge.net/project/lmod/Lmod-7.5.tar.bz2            
    tar xvf Lmod-7.5.tar.bz2   
    cd Lmod-7.5
    ./configure --prefix=/opt/apps
    make install
    make install
    cp /opt/apps/lmod/lmod/init/profile /etc/profile.d/profile.sh
    cd
    source /etc/profile.d/profile.sh
    
    # install easybuild
    cd /
    wget https://raw.githubusercontent.com/hpcugent/easybuild-framework/develop/easybuild/scripts/bootstrap_eb.py
    PREFIX=/opt/apps/easybuild
    chmod 777 /opt /opt/apps 
    useradd easybuild
    mkdir /easybuild
    chown easybuild:easybuild /easybuild
    runuser easybuild -c "python /bootstrap_eb.py $PREFIX"
    chmod 755 /opt /opt/apps

%environment
    export MODULEPATH=/opt/apps/easybuild/modules/all:$MODULEPATH
    . /etc/profile
