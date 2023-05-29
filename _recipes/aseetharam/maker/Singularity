Bootstrap: docker
From: ubuntu:18.04

%environment
   export PATH=$PATH:/usr/local/src/snap:/opt/trf/bin:/opt/rmblast-2.10.0/bin:/opt/trf/bin/
   export ZOE=/usr/local/src/snap/Zoe
   export PATH=$PATH:/opt/RepeatMasker/util:/opt/RepeatMasker
   export PATH=$PATH:/opt/maker/bin
   export PERL5LIB=$PERL5LIB:/opt/RepeatMasker:/opt/maker/lib:/opt/maker/perl/lib

%labels
    Author Arun Seetharam
    Version v1
    Maintainer arnstrm@iastate.edu

%help
    This is a container for the MAKER gene prediction software
    All tools have been configured to run with MAKER except for GeneMaker-ET

%test
   which perl
#   which maker
   which snap
   which RepeatMasker
   which augustus
   echo $AUGUSTUS_CONFIG_PATH

%post
   apt-get update
   apt-get install -y build-essential wget curl git autoconf
   apt-get install -y gcc g++ make
   apt-get install -y zlib1g-dev libgomp1 libgomp1 libpam-systemd-
   apt-get install -y gfortran
   apt-get install -y perl bioperl libfile-which-perl libtext-soundex-perl libjson-perl liburi-perl libwww-perl 
   apt-get install -y ncbi-blast+
   apt-get install -y hmmer
   apt-get install -y cd-hit
   apt-get install -y exonerate
   apt-get install -y augustus augustus-data augustus-doc
   apt-get install -y hwloc-nox libc6 libcr0 libhwloc5 libmpich12 libmpich-dev blcr-util mpich-doc
#install snap
   git clone --recursive https://github.com/KorfLab/SNAP.git /usr/local/src/snap
   cd /usr/local/src/snap
   git reset --hard a89d68e8346337c155b99697389144dfb5470b0f
   make
   export PATH=$PATH:/usr/local/src/snap
   export ZOE=/usr/local/src/snap/Zoe
## install repeatmasker
# get trf
   cd /opt
   wget http://tandem.bu.edu/trf/downloads/trf409.linux64
   mkdir -p /opt/trf/bin
   mv trf409.linux64 /opt/trf/bin/trf
# get rmblast
   cd /opt
   wget http://www.repeatmasker.org/rmblast-2.10.0+-x64-linux.tar.gz
   tar xf rmblast-2.10.0+-x64-linux.tar.gz
   rm rmblast-2.10.0+-x64-linux.tar.gz
# repeatmasker
   cd /opt
   wget http://www.repeatmasker.org/RepeatMasker-4.1.0.tar.gz
   tar xf RepeatMasker-4.1.0.tar.gz
   rm RepeatMasker-4.1.0.tar.gz
   cd RepeatMasker
   perl configure \
      -hmmer_dir=/usr/bin \
      -rmblast_dir=/opt/rmblast-2.10.0/bin \
      -libdir=/opt/RepeatMasker/Libraries \
      -trf_prgm=/opt/trf/bin/trf \
      -default_search_engine=rmblast 
   wget https://github.com/lfaino/LoReAn/raw/noIPRS/third_party/software/RepeatMasker.Libraries.tar.gz
   rm -rf /opt/RepeatMasker/Libraries
   tar -zxf RepeatMasker.Libraries.tar.gz
   chmod -R 755 /opt/RepeatMasker/Libraries
   rm -f RepeatMasker.Libraries.tar.gz
   export PATH=$PATH:/opt/RepeatMasker/util:/opt/RepeatMasker
   export PERL5LIB=$PERL5LIB:/opt/RepeatMasker
# genemark

# maker
#   cd /opt
#   wget http://yandell.topaz.genetics.utah.edu/maker_downloads/47DA/F2FC/9A91/967425BE163605C14F4A5434EAF7/maker-2.31.11.tgz
#   tar xf maker-2.31.11.tgz
#   rm maker-2.31.11.tgz
#   cd maker/src
#   echo Y | perl ./Build.PL
#   ./Build installdeps
#   ./Build install

