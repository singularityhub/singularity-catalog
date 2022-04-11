Bootstrap:docker
From:centos:centos7.4.1708

%help
    Container for Bovine DNA and RNA tools

%labels
    MAINTAINER Colin Sauze

%environment
    #define environment variables here
    
%post  


    #essential utilities
    yum -y install git wget bzip2 unzip which

    #language and libraries
    yum -y install java-1.8.0-openjdk-devel gcc gcc-c++ glibc-devel make ncurses-devel zlib-devel libbzip2-devel bzip2-devel xz-devel perl-DBI lapack-devel atlas-devel
    #libclas and libatlas aren't put in the right places
    ln -s /usr/lib64/atlas/libtatlas.so /usr/lib64/libatlas.so
    ln -s /usr/lib64/atlas/libsatlas.so /usr/lib64/libcblas.so

    yum -y install https://centos7.iuscommunity.org/ius-release.rpm
    yum -y install python36u python36u-pip python36u-devel


    mkdir -p /usr/local/src
    cd /usr/local/src
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
    
    
    # ensembl vep
    # note built without mysql support, error message:
    # WARNING: DBD::mysql module not found. VEP can only run in offline (--offline) mode without DBD::mysql installed
    # 
    yum install -y perl-CPAN perl-IO-Socket-SSL perl-Archive-Any perl-YAML perl-CPAN-Meta perl-Digest-MD5 perl-App-cpanminus perl-local-lib

    #we only have US locales installed and complaints happen if host system locale is something different 
    export LANG=en_US.UTF-8
 
    #samtools
    wget https://github.com/samtools/samtools/releases/download/1.8/samtools-1.8.tar.bz2
    tar xf samtools-1.8.tar.bz2
    cd samtools-1.8
    ./configure --prefix=/usr/local/
    make
    make install
    cd /usr/local/src   

    #bcftools
    wget https://github.com/samtools/bcftools/releases/download/1.8/bcftools-1.8.tar.bz2
    tar xf bcftools-1.8.tar.bz2
    cd bcftools-1.8
    ./configure --prefix=/usr/local
    make
    make install
    cd /usr/local/src
    

    #htslib
    wget https://github.com/samtools/htslib/releases/download/1.8/htslib-1.8.tar.bz2
    tar xf htslib-1.8.tar.bz2
    cd htslib-1.8
    ./configure --prefix=/usr/local
    make
    make install
    cd /usr/local/src  
 
    #ensembl vep 
    #the Vep installer needs ensembl which needs bioperl, ensembl didn't have a cpan or rpm package, installing like its 1990!
    cd /usr/local/lib
    wget ftp://ftp.ensembl.org/pub/ensembl-api.tar.gz
    wget https://cpan.metacpan.org/authors/id/C/CJ/CJFIELDS/BioPerl-1.6.924.tar.gz 
    tar xf ensembl-api.tar.gz
    tar xf BioPerl-1.6.924.tar.gz 
      
    export PERL5LIB=${PERL5LIB}:/usr/local/lib/ensembl/modules:/usr/local/lib/ensembl-io/modules:/usr/local/lib/ensembl-variation/modules:/usr/local/lib/ensembl-funcgen/modules
    
        
    #but the bioperl we just downloaded is missing the DB:HTS module, so use cpan to install it
    #this prompts us to install a load of extra bits of bioperl, tell it not to
    #yes n | cpan install Bio::DB::HTS
    cpanm install --force Bio::DB::HTS #version mismatch in the tests requires forcing, actual program ok
        
    #cpan Module::Build

    cd /usr/local/src
   
    wget https://github.com/Ensembl/ensembl-vep/archive/release/92.5.tar.gz
    tar xf 92.5.tar.gz
    cd ensembl-vep-release-92.5   

    echo "y" > commands
    echo "y" >> commands #agree to install cache files 
    echo "10" >> commands #choose bos_taurus_merged_vep_92_UMD3.1.tar.gz
    echo "y" >> commands #overrite cached files, is this needed?
    echo "n" >> commands #don't install FASTA files
    echo "n" >> commands #don't install plugins
    
    perl ./INSTALL.pl < commands #this has several prompts which need to worked out, which datasets do we want from it?
    cd /usr/local/src   

    



    #bedtools
    wget https://github.com/arq5x/bedtools2/releases/download/v2.27.1/bedtools-2.27.1.tar.gz
    tar xf bedtools-2.27.1.tar.gz
    cd bedtools2
    make
    make install
    cd /usr/local/src
    
    #picard
    wget https://github.com/broadinstitute/picard/releases/download/2.18.9/picard.jar -O /usr/local/lib/picard.jar
 
    
   
    #BWA
    wget https://github.com/lh3/bwa/releases/download/v0.7.17/bwa-0.7.17.tar.bz2
    tar xf bwa-0.7.17.tar.bz2
    cd bwa-0.7.17
    make
    mv bwa /usr/local/bin
    mv *.pl /usr/local/bin
    mv libbwa.a /usr/local/lib
    cd /usr/local/src
  
    
    
     
    #STAR
    wget https://github.com/alexdobin/STAR/archive/2.6.0c.tar.gz
    tar xf 2.6.0c.tar.gz
    cd STAR-2.6.0c/source
    make STAR
    mv STAR /usr/local/bin
    #make install
    cd /usr/local/src
    
    

    #pigz
    wget https://github.com/madler/pigz/archive/v2.4.tar.gz
    tar xf v2.4.tar.gz
    cd pigz-2.4
    make
    mv pigz /usr/local/bin
    mv unpigz /usr/local/bin
    cd /usr/local/src     
    

    #kallisto
    wget https://github.com/pachterlab/kallisto/releases/download/v0.44.0/kallisto_linux-v0.44.0.tar.gz
    tar xf kallisto_linux-v0.44.0.tar.gz
    mv kallisto_linux-v0.44.0/kallisto /usr/local/bin
     
    
    
    
    #fastqc
    wget https://github.com/s-andrews/FastQC/archive/v0.11.7.tar.gz
    tar xf v0.11.7.tar.gz
    cd FastQC-0.11.7
    mv *.jar /usr/local/lib
    mv fastqc /usr/local/bin
    chmod 755 /usr/local/bin/fastqc
    cd /usr/local/src     
    
    
    #multiqc
    pip3.6 install multiqc
    
    #BBMap
    wget "https://downloads.sourceforge.net/project/bbmap/BBMap_38.11.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fbbmap%2Ffiles%2FBBMap_38.11.tar.gz%2Fdownload&ts=1531223392" -O BBMap_38.11.tar.gz
   
    tar xf BBMap_38.11.tar.gz
    #its all shell scripts, don't really know where to put them
    echo "BBmap done"
    read r       
    
    
    
    #gatk
    wget https://github.com/broadinstitute/gatk/releases/download/4.0.6.0/gatk-4.0.6.0.zip
    unzip gatk-4.0.6.0.zip
    cd gatk-4.0.6.0
    mv gatk-package-4.0.6.0-local.jar /usr/local/lib
    mv gatk /usr/local/bin
    mv gatk-completion.sh /usr/local/bin
    cd /usr/local/src     
    
    #don't think we need anything from the scripts subdir
    
    #SnpEff
    wget http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip
    unzip snpEff_latest_core.zip
    echo "snpeff done"
    read r       
    
    # doesn't really make sense to put this elsewhere in /usr/local, so just leaving it in /usr/local/src
   
    #plink-ng
    wget https://github.com/chrchang/plink-ng/archive/b0cec5e.tar.gz
    tar xf b0cec5e.tar.gz
    cd plink-ng-b0cec5e/2.0/build_dynamic
    make
    mv plink2 /usr/local/bin
    mv pgen_compress /usr/local/bin
    cd /usr/local/src    
    
    
    mkdir /data
    cd /data
    
    #only needed to speed things up in aber
    #export http_proxy="http://wwwcache.aber.ac.uk:8080"
    
    #1000 Bulls
    wget http://www.1000bullgenomes.com/doco/1000bulls_v6_annotated_snps.tab.gz
    wget http://www.1000bullgenomes.com/doco/1000bulls_v6_annotated_indels.tab.gz
    
    #data download
    #DNA genome fasta (toplevel no masking)
    wget ftp://ftp.ensembl.org/pub/release-92/fasta/bos_taurus/dna/Bos_taurus.UMD3.1.dna.toplevel.fa.gz

    #cDNA genome fasta
    wget ftp://ftp.ensembl.org/pub/release-92/fasta/bos_taurus/cdna/Bos_taurus.UMD3.1.cdna.all.fa.gz

    #CDS fasta
    wget ftp://ftp.ensembl.org/pub/release-92/fasta/bos_taurus/cds/Bos_taurus.UMD3.1.cds.all.fa.gz

    #ncRNA fasta
    wget ftp://ftp.ensembl.org/pub/release-92/fasta/bos_taurus/ncrna/Bos_taurus.UMD3.1.ncrna.fa.gz

    #GTF
    wget ftp://ftp.ensembl.org/pub/release-92/gtf/bos_taurus/Bos_taurus.UMD3.1.92.abinitio.gtf.gz
    wget ftp://ftp.ensembl.org/pub/release-92/gtf/bos_taurus/Bos_taurus.UMD3.1.92.chr.gtf.gz
    wget ftp://ftp.ensembl.org/pub/release-92/gtf/bos_taurus/Bos_taurus.UMD3.1.92.gtf.gz

    #variants
    wget ftp://ftp.ensembl.org/pub/release-92/variation/vcf/bos_taurus/bos_taurus_incl_consequences.vcf.gz


    
    
%runscript
    #set locale so multiqc doesn't complain
    export LANG=en_US.UTF-8
    
    #running stuff

