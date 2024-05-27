Bootstrap: docker
From: ubuntu:trusty-20170817

%help
A Singulairty image for Shovill

%labels
Maintainer Kristy Horan & Anders Goncalves da Silva
Build 1.0

%environment
    SHOVILL_VERSION=0.9.0
    SPADES_VERSION=3.11.1
    SEQTK_VERSION=1.2
    KMC_VERSION=3
    SAMTOOLS_VERSION=1.7
    BWA_VERSION=0.7.17
    LIGHTER_VERSION=1.1.1
    FLASH_VERSION=1.2.11
    PILON_VERSION=1.22
    TRIMMOMATIC_VERSION=0.36
    export SHOVILL_VERSION SPADES_VERSION SEQTK_VERSION KMC_VERSION SAMTOOLS_VERSION BWA_VERSION LIGHTER_VERSION FLASH_VERSION PILON_VERSION TRIMMOMATIC_VERSION

%post

    SHOVILL_VERSION=0.9.0
    SPADES_VERSION=3.11.1
    SEQTK_VERSION=1.2
    KMC_VERSION=3
    SAMTOOLS_VERSION=1.7
    BWA_VERSION=0.7.17
    LIGHTER_VERSION=1.1.1
    FLASH_VERSION=1.2.11
    PILON_VERSION=1.22
    TRIMMOMATIC_VERSION=0.36

    sudo locale-gen en_US.UTF-8
    sudo update-locale

    sudo apt-get --yes update
    sudo apt-get --yes install unzip pigz git-all gcc openjdk-7-jre-headless g++ make libz-dev wget tar liblzma-dev libbz2-dev liblist-moreutils-perl libmoo-perl libjson-perl libncurses5-dev python


    echo "Installing Shovill dependencies"

    # navigate to opt
    cd /opt/

    echo "SPAdes"

    #set variables for versions
    SPADES=SPAdes-${SPADES_VERSION}-Linux

    # download and unpack in opt
    wget http://spades.bioinf.spbau.ru/release${SPADES_VERSION}/$SPADES.tar.gz
    tar xf $SPADES.tar.gz


    echo "SEQTK"
    SEQTK=v${SEQTK_VERSION}.tar.gz
    # download and unpack in opt
    wget https://github.com/lh3/seqtk/archive/$SEQTK
    tar xf $SEQTK
    make -C seqtk-${SEQTK_VERSION}
    chmod g-w seqtk-${SEQTK_VERSION}/seqtk

    echo "KMC"
    KMC=KMC${KMC_VERSION}.linux.tar.gz
    wget https://github.com/refresh-bio/KMC/releases/download/v3.0.0/$KMC
    tar xf $KMC
    rm -fv kmc_dump kmc_tools

    echo "SAMtools"
    SAMTOOLS=samtools-${SAMTOOLS_VERSION}
    #unpack into SAMTOOLS
    wget https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/$SAMTOOLS.tar.bz2
    tar xf $SAMTOOLS.tar.bz2
    # check build environment
    cd $SAMTOOLS
    ./configure
    # build samtools
    make
    make install
    # return to /opt/
    cd ..

    echo "BWA"
    BWA=bwa-${BWA_VERSION}
    wget https://github.com/lh3/bwa/releases/download/v${BWA_VERSION}/$BWA.tar.bz2
    tar xf $BWA.tar.bz2
    make --silent -j -C $BWA

    echo "Lighter"
    LIGHTER=v${LIGHTER_VERSION}.tar.gz
    wget https://github.com/mourisl/Lighter/archive/$LIGHTER
    tar xf $LIGHTER
    make --silent -j -C Lighter-${LIGHTER_VERSION}

    echo "FLASH"
    FLASH=FLASH-${FLASH_VERSION}
    wget https://downloads.sourceforge.net/project/flashpage/$FLASH.tar.gz
    tar xf $FLASH.tar.gz
    make --silent -j -C $FLASH

    # add this to path :/opt/$FLASH

    echo "PILON"
    JAR=pilon-${PILON_VERSION}.jar
    PILON=pilon
    #get pilon
    if [ -e $PILON ]
    then
        echo "PILON already downloaded"
    else
        wget https://github.com/broadinstitute/pilon/releases/download/v${PILON_VERSION}/$JAR
    fi
    #write script and save to a file called pilon
    echo "exec java -jar /opt/$JAR" '"$@"' > $PILON
    #make pilon executable
    chmod +x $PILON

    echo "Trimmomatic"
    TRIM=Trimmomatic-0.36
    TRIMSH=trimmomatic
    #get trimmomatc and unzip
    wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/$TRIM.zip
    echo "Trimmomatic downloaded"

    if [ -d $TRIM ]
    then
        echo "Trimmomatic already installed"
    # write script to and save to trim
    else
        unzip $TRIM
        echo "Trimmomatic unzipped"
        echo "exec java -jar /opt/Trimmomatic-0.36/trimmomatic-0.36.jar" '"$@"' > $TRIMSH
        # make it executable
        chmod +x $TRIMSH
    fi

    if [ -d shovill ]
    then
        echo "Shovill has already been installed. Thank you, thank you"
    else
        echo "Drumroll please.... Shovill"
        git clone https://github.com/tseemann/shovill.git
    fi

    echo "Sorting some env variables..."
    sudo echo 'LANGUAGE="en_US:en"' >> $SINGULARITY_ENVIRONMENT
    sudo echo 'LC_ALL="en_US.UTF-8"' >> $SINGULARITY_ENVIRONMENT
    sudo echo 'LC_CTYPE="UTF-8"' >> $SINGULARITY_ENVIRONMENT
    sudo echo 'LANG="en_US.UTF-8"' >>  $SINGULARITY_ENVIRONMENT
    sudo echo "PATH=$PATH:/opt/$SPADES/bin:/opt:/opt/seqtk-1.2:/opt/$SAMTOOLS:/opt/$BWA:/opt/Lighter-1.1.1:/opt/$FLASH:/opt/shovill/bin" >>  $SINGULARITY_ENVIRONMENT

    echo "Deleting source files"
    rm  *.tar.*
    rm *.zip*


%runscript
  echo "Welcome to MDU SHOVILL ${SHOVILL_VERSION}" >&2
  exec shovill "$@"

%test
    # need to add dirs to PATH to run tests
    VERSION=3.11.1
    SPADES=SPAdes-${VERSION}-Linux
    SAMTOOLS=samtools-1.7
    BWA=bwa-0.7.17
    FLASH=FLASH-1.2.11
    PATH=$PATH:/opt/$SPADES/bin:/opt:/opt/seqtk-1.2:/opt/$SAMTOOLS:/opt/$BWA:/opt/Lighter-1.1.1:/opt/$FLASH:/opt/shovill/bin
    echo "Testing shovill dependencies"
    shovill --check
