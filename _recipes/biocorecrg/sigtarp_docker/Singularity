Bootstrap: docker
From: biocorecrg/debian-perlbrew:stretch

%runscript
echo "Welcome to BiocoreCRG Sigtarp Image"

%post

	ln -s /external/signalp/signalp /usr/local/bin/signalp
	ln -s /external/targetp/targetp /usr/local/bin/targetp
	ln -s /external/chlorop/chlorop /usr/local/bin/chlorop

	chmod a+rx /usr/local/bin/*

%files

	external/signalp /external/
	external/targetp /external/
    	external/chlorop /external/

