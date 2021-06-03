Bootstrap: docker
From: bioperl/bioperl
Stage: devel

%labels
	author Stefano Ghignone
	maintainer sghignone
	name RNNOTATOR
	version 3.5(released YY-MM-DD) 

%environment
	export PATH=/usr/local/bin:$PATH

%post
	apt  update && apt -y full-upgrade && apt -y install build-essential wget git

	export LC_ALL="C.UTF-8"
	export LANG="C.UTF-8"
	echo 'export LC_ALL=C.UTF-8' >> "$SINGULARITY_ENVIRONMENT"
	echo 'export LANG=C.UTF-8' >> "$SINGULARITY_ENVIRONMENT"

	curl -L http://cpanmin.us | perl - --sudo App::cpanminus
	cpanm --quiet --notest Statistics::Descriptive Parallel::ForkManager Tree
	
	#Install BLAT
	wget -c http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/blat/blat -P /usr/local/bin
	chmod +x /usr/local/bin/blat
	
	#Move to install DIR
	cd /opt

	#Installing VELVET
	git clone https://github.com/dzerbino/velvet.git
	cd velvet && make
	chmod +x velvet?
	cd ..

	#Installing OASES
	git clone --recursive https://github.com/dzerbino/oases
	cd oases && make
	chmod +x oases
	cd ..

	#Installing BWA
	wget -c https://sourceforge.net/projects/bio-bwa/files/bwa-0.7.17.tar.bz2 -P /opt
	tar -xf bwa-0.7.17.tar.bz2 -C /opt
	cd bwa-0.7.17 && make
	cd ..
	rm bwa-0.7.17.tar.bz2

	#Installing MUMMER
	wget -c https://sourceforge.net/projects/mummer/files/mummer/3.23/MUMmer3.23.tar.gz -P /opt
	tar -xzf MUMmer3.23.tar.gz -C /opt
	cd MUMmer3.23 && make install
	cd .. 
	rm MUMmer3.23.tar.gz
	ln -s /opt/MUMmer3.23/nucmer /usr/bin/.
	ln -s /opt/MUMmer3.23/show-coords /usr/bin/.
	ln -s /opt/MUMmer3.23/delta-filter /usr/bin/.

	#Installing VMATCH
	wget -c http://www.vmatch.de/distributions/vmatch-2.3.1-Linux_x86_64-64bit.tar.gz -P /opt
	tar -xzf vmatch-2.3.1-Linux_x86_64-64bit.tar.gz -C /opt
	rm vmatch-2.3.1-Linux_x86_64-64bit.tar.gz

%environment
	export PATH=/opt/velvet:/opt/velvet/contrib/AssemblyAssembler1.3:/opt/oases:/opt/bwa-0.7.17:/opt/MUMmer3.23:/opt/MUMmer3.23/scripts:/opt/vmatch-2.3.1-Linux_x86_64-64bit:$PATH
	export LD_LIBRARY_PATH=/opt/vmatch-2.3.1-Linux_x86_64-64bit/SELECT:$PATH	

%post
	#Installing AMOS
	wget -c https://sourceforge.net/projects/amos/files/amos/3.1.0/amos-3.1.0.tar.gz -P /opt
	tar -xzf amos-3.1.0.tar.gz -C /opt
#	cd amos-3.1.0 && ./configure  CXXFLAGS="-g -O2 -Wno-narrowing"
	#The solution is to editsrc/Align/find-tandem.ccFile, add at the beginning#include <getopt.h>	
	sed -i '1s/^/#include <getopt.h>\n/' amos-3.1.0/src/Align/find-tandem.cc
	cd amos-3.1.0 && ./configure && make && make install  
	cd ..
	rm  amos-3.1.0.tar.gz

%environment
        export PATH=/opt/amos-3.1.0/bin:$PATH
