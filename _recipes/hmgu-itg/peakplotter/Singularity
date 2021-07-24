Bootstrap: docker
From: ubuntu:18.04

%environment
    export TZ=Europe/Berlin
    export PATH=/usr/local/bin:/opt/locuszoom/bin:/opt/plink:$PATH
    
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8

%post
    apt update
    export TZ=Europe/Berlin
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
    
    apt install -y tabix moreutils git wget zip unzip python3-pip r-base sqlite3


# locuszoom    
    cd /opt
	wget https://statgen.sph.umich.edu/locuszoom/download/locuszoom_1.4_srconly.tgz
	tar -zxf locuszoom_1.4_srconly.tgz
	rm locuszoom_1.4_srconly.tgz
	
	mkdir locuszoom/conf
	touch locuszoom/conf/m2zfast.conf
	cat <<-EOF >locuszoom/conf/m2zfast.conf
	METAL2ZOOM_PATH="bin/locuszoom.R"
	NEWFUGUE_PATH=""
	PLINK_PATH="plink"
	RSCRIPT_PATH="Rscript"
	TABIX_PATH="tabix"
	SQLITE_DB={"b38":""}
	DEFAULT_BUILD="b38"
	DEFAULT_POP="EUR"
	DEFAULT_SOURCE="b38"
	GWAS_CATS={"b38":{}}
	LD_DB={"b38":{}}
	EOF


# Bedtools
    apt install -y python-pip
    apt-get install -y zlib1g zlib1g-dev firefox python-dev emacs
    pip install scipy pandas numpy scikit-learn==0.14.1

# PLINK
    cd /opt
    mkdir plink
    cd plink
    wget http://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20201019.zip
    unzip plink_linux_x86_64_20201019.zip
    rm plink_linux_x86_64_20201019.zip


# PeakPlotter
    cd /opt
    git clone https://github.com/hmgu-itg/peakplotter.git
    cd peakplotter
    python3 -m pip install .
    
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8    
    peakplotter-data-setup 
    chmod -R 777 /usr/local/lib/python3.6    

%runscript
exec python3 -m peakplotter "$@"
