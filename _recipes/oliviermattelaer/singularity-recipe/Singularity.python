BootStrap: debootstrap
OSVersion: stable
MirrorURL: http://ftp.us.debian.org/debian/

%runscript
    python /usr/local/bin/helloworld.py $@


%post
    echo "Hello from inside the container"
    apt-get update
    apt-get -y install  python
    #	        apt-get clean

%files
   helloworld.py /usr/local/bin

%labels
   author Olivier Mattelaer

%environment
    export PATH=$PATH:/usr/games
    export LC_ALL=C
	