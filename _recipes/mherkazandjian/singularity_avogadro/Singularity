BootStrap: debootstrap
OSVersion: bionic
MirrorURL: http://us.archive.ubuntu.com/ubuntu/


%runscript
    avogadro


%post
    echo "Hello from inside the container"
    sed -i 's/$/ universe/' /etc/apt/sources.list
    apt-get update
    apt-get -y install vim
    apt-get -y install avogadro
    apt-get clean
