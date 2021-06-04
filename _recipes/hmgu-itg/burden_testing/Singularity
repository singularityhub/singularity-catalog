Bootstrap: docker
From: ubuntu:18.04

%environment
	TZ=Europe/Berlin
        PERL_MM_USE_DEFAULT=1
	export PERL_MM_USE_DEFAULT
	PERL_EXTUTILS_AUTOINSTALL="--defaultdeps"
	export PERL_EXTUTILS_AUTOINSTALL
	
	PATH=$PATH:/usr/local/bin:/usr/local/bin/burden_testing:/usr/local/bin/burden_testing/testing:/usr/local/bin/MONSTER:/usr/local/bin/bedtools2/bin/:/usr/local/bin/UCSC.tools
	export PATH
	
	LC_ALL=C
	export LC_ALL
	
%post
	apt update
	DEBIAN_FRONTEND="noninteractive" apt-get install -y software-properties-common
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
	add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'

	DEBIAN_FRONTEND="noninteractive" apt install -y software-properties-common build-essential autoconf libtool bc man git curl wget make moreutils libbz2-dev zlib1g-dev libncurses5-dev libncursesw5-dev liblzma-dev unzip python libgsl-dev r-base libcurl4-openssl-dev axel

	cd /root
	git clone git://github.com/samtools/htslib.git
	cd htslib
	make tabix && make bgzip && cp bgzip tabix /usr/bin

	cd /root	
	git clone git://github.com/samtools/bcftools.git
	cd bcftools
	make bcftools && cp bcftools /usr/bin
	
	Rscript --vanilla -e "install.packages(c(\"reshape2\",\"R.utils\", \"parallel\", \"Hmisc\", \"argparser\", \"data.table\", \"BiocManager\", \"doMC\"),repos = \"http://cran.us.r-project.org\");BiocManager::install(c(\"SeqArray\", \"SeqVarTools\"));install.packages(\"GMMAT\", repos = \"http://cran.us.r-project.org\")"
	perl -MCPAN -e 'foreach (@ARGV) { CPAN::Shell->rematein("notest", "install", $_) }' Module::Build DBI Try::Tiny JSON Data::Dumper File::Basename Getopt::Long Data::Types File::Path

	cd /usr/local/bin
	git clone https://github.com/hmgu-itg/burden_testing
		
	cd /usr/local/bin
	mkdir UCSC.tools
	cd UCSC.tools
	wget http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64.v385/liftOver
	chmod +x liftOver
	
	cd /usr/local/bin
	wget http://www.stat.uchicago.edu/~mcpeek/software/MONSTER/MONSTER_v1.3.tar.gz
	tar -zxf MONSTER_v1.3.tar.gz
	rm MONSTER_v1.3.tar.gz
	cd MONSTER
	make
	chmod o+rx /usr/local/bin/MONSTER
	
	cd /usr/local/bin
	wget https://github.com/arq5x/bedtools2/releases/download/v2.29.1/bedtools-2.29.1.tar.gz
	tar -zxf bedtools-2.29.1.tar.gz
	rm bedtools-2.29.1.tar.gz
	cd bedtools2
	make
	
	cd /usr/local/bin
	wget https://sourceforge.net/projects/transpose/files/transpose/transpose-2.0/2.0/transpose-2.0.zip
	unzip transpose-2.0.zip
	rm transpose-2.0.zip	
	cd transpose-2.0/src
	gcc transpose.c -o transpose2
	mv transpose2 /usr/local/bin
	cd /usr/local/bin
	rm -rf transpose-2.0/
	
	CREATIONDATE=`date`

%runscript
	echo "This container was created: $CREATIONDATE"

%labels
	Author Arthur Gilly, Andrei Barysenka, Daniel Suveges, Young-Chan Park
	Version v1.5.1

%help
	This container allows you to run rare variant aggregation tests using MONSTER and SMMAT; for more information run this container with the help command line option.


