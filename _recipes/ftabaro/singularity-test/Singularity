Bootstrap: docker
From: centos:8

%setup

%files

%help
   Tools for MethylSnake pipeline. For complete list and instructions see: https://github.com/ftabaro/MethylSnake/tree/master/singularity

%labels
   Author francesco.tabaro@tuni.fi
   Version 1

%post
  set -e
  
  NOW=`date`
  echo "export NOW=\"${NOW}\"" >> $SINGULARITY_ENVIRONMENT

  dnf -y makecache
  dnf -y group install "Development Tools"
  dnf -y install --allowerasing hostname which \
	dnf-utils \
	git \
	unzip \
	wget \
	rsync \
	zlib zlib-devel \
	bzip2 bzip2-devel \
	xz xz-devel \
	libcurl libcurl-devel \
	ncurses ncurses-devel \
	java-1.8.0-openjdk java-1.8.0-openjdk-devel \
	openssl-devel \
	libffi-devel \
	cairo cairo-devel \
	fontconfig fontconfig-devel \
	freetype freetype-devel \
	fribidi fribidi-devel \
	glib2 glib2-devel \
	libcurl libcurl-devel \
	libicu libicu-devel \
	libjpeg libjpeg-devel \
	libpng libpng-devel \
	libtiff libtiff-devel \
	libtirpc libtirpc-devel \
	libxcrypt libxcrypt-devel \
	pango pango-devel \
	pcre pcre-devel \
	readline readline-devel \
	zlib zlib-devel \
	openblas \
	lapack \
	gcc-gfortran \
	boost boost-devel \
	texlive \
	libxml2-devel \
	python3-pip python36-devel

  ln -s /usr/bin/python3 /usr/bin/python
  ln -s /usr/bin/pip3 /usr/bin/pip

  pip install numpy pandas matplotlib scikit-learn scipy opencv-contrib-python

  # Intel Threading Building Blocks 2019 U8
  echo "/usr/local/lib" >> /etc/ld.so.conf.d/usr_local_lib.conf
  rm -rf tbb
  git clone https://github.com/intel/tbb
  cd tbb
  make -j 2
  find . -name '*so' | grep release | xargs -I{} cp {} /usr/local/lib/  # Copy release libs to sys dir
  find . -name '*so.2' | grep release | xargs -I{} cp {} /usr/local/lib/
  cp -R include/* /usr/local/include/
  cd ..
  ldconfig
  mkdir -p /usr/local/lib64/python3.6/site-packages

# ################### Samtools #################################

%apprun samtools
   exec samtools

%appinstall samtools
   rm -rf htslib
   git clone https://github.com/samtools/htslib
   cd htslib
   autoheader
   autoconf
   ./configure
   make -j 2
   make install
   cd ..
   rm -rf samtools
   git clone https://github.com/samtools/samtools
   cd samtools
   autoheader
   autoconf -Wno-syntax
   ./configure
   make -j 2
   make install
   cd ..

%apphelp samtools
   Samtools 1.9. https://github.com/samtools/samtools

# ######################## Bowtie2 ################################

%apprun bowtie2
   exec bowtie2

%appinstall bowtie2
   wget -O bowtie.zip https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.5.1/bowtie2-2.3.5.1-source.zip/download
   unzip -o bowtie.zip
   cd bowtie2-2.3.5.1
   make -j 2
   cp bowtie2* /usr/local/bin/
   cd ..


%apphelp bowtie2
   Bowtie 2 v. 2.3.5.1 . http://bowtie-bio.sourceforge.net/bowtie2/index.shtml

# ######################## Cutadapt ################################

%apprun cutadapt
   exec cutadapt

%appinstall cutadapt
   pip install cutadapt

%apphelp cutadapt
   Cutadapt 2.4.. https://cutadapt.readthedocs.io/en/stable/guide.html

# ############################ TrimGalore ########################

%apprun trim_galore
   exec trim_galore

%appinstall trim_galore
   curl -fsSL https://github.com/FelixKrueger/TrimGalore/archive/0.6.5.tar.gz -o trim_galore.tar.gz
    tar xzf trim_galore.tar.gz
    cp TrimGalore-0.6.5/trim_galore /usr/local/bin
    rm -r TrimGalore-0.6.5


%apphelp trim_galore
    TrimGalore (0.6.5) . https://github.com/FelixKrueger/TrimGalore

# ############################ Bismark ########################

%apprun bismark
   exec bismark

%appinstall bismark
    curl -fsSL https://github.com/FelixKrueger/Bismark/archive/0.22.3.tar.gz -o Bismark_0.22.3.tar.gz
    tar xzf Bismark_0.22.3.tar.gz -C /opt/

%apphelp bismark
    Bismark (0.22.3) . https://github.com/FelixKrueger/Bismark

# ############################ R + Bioconductor + methylKit ########################

%apprun R
   exec R

%apphelp R
    R (4.0.2) . https://www.r-project.org/

%appinstall R
 
  wget https://cran.r-project.org/src/base/R-4/R-4.0.2.tar.gz
  tar xf R-4.0.2.tar.gz
  cd R-4.0.2
  ./configure --without-x 
  make -j2
  make install
  cd ..
  rm -r R-4.0.2

  R -e "install.packages('BiocManager', repos = 'https://cloud.r-project.org')"
  R -e "BiocManager::install(version = '3.11')"
  R -e "BiocManager::install('rtracklayer')"
  R -e "BiocManager::install('methylKit')"

# ############################ gtfToGenePred ########################

%apprun gtfToGenePred
   exec gtfToGenePred

%apphelp gtfToGenePred
   gtfToGenePred (1.04.00) . https://hgdownload.soe.ucsc.edu/downloads.html

%appinstall gtfToGenePred
   curl -o /usr/local/bin/gtfToGenePred http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/gtfToGenePred
   chmod +x /usr/local/bin/gtfToGenePred

# ############################ genePredToBed ########################

%apprun genePredToBed
   exec genePredToBed

%apphelp genePredToBed
   genePredToBed (1.04.00) . https://hgdownload.soe.ucsc.edu/downloads.html

%appinstall genePredToBed
   curl -o /usr/local/bin/genePredToBed http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/genePredToBed
   chmod +x /usr/local/bin/genePredToBed


