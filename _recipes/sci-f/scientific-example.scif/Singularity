# To build the container:
# sudo singularity build <container> Singularity

Bootstrap: docker
From: ubuntu:14.04

# =======================
# global
# =======================

%post

    locale-gen "en_US.UTF-8"
    dpkg-reconfigure locales
    export LANGUAGE="en_US.UTF-8"
    echo 'LANGUAGE="en_US.UTF-8"' >> /etc/default/locale
    echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale

    apt-get update
    apt-get install -y apt-transport-https build-essential cmake curl libsm6 libxrender1 libfontconfig1 wget git unzip python-setuptools ruby bc
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51716619E084DAB9
    echo "deb https://cloud.r-project.org/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list
    apt-get update
    apt-get install -y r-base-dev gdebi-core
    apt-get clean


%runscript

    if [ $# -eq 0 ]; then
        echo "\nThe following software is installed in this image:"
        ls /scif/apps | sort -u --ignore-case        
        echo "Example usage: singularity --app <name> <container> [command] [args] [options]"  
    else
        exec "$@"
    fi
        

%help
    This container is an example container to provide several steps of a genomic analysis pipeline.
    You generally would want to specify a path on your host to mount for data ($DATA) and
    do the following:

    # Download data, these can be run in parallel
    singularity run --app download-fastq -B $DATA:/scif/data <container>
    singularity run --app download-reference -B $DATA:/scif/data <container>
    singularity run --app download-rtg -B $DATA:/scif/data <container>

    singularity run --app simulate-reads -B $DATA:/scif/data <container>
    singularity run --app transcript -B $DATA:/scif/data <container>
    singularity run --app bwa-index-align -B $DATA:/scif/data <container>
    singularity run --app run-rtg -B $DATA:/scif/data <container>


%environment
    DATADIR=/scif/data
    REF_DIR=${DATADIR}/Reference
    FASTQ_DIR=${DATADIR}/Fastq
    RTG_DIR=${DATADIR}/RTG
    NUMCORES=$(nproc)
    export RTG_DIR DATADIR REF_DIR FASTQ_DIR NUMCORES


# =======================
# download
# =======================

%apprun download-fastq
    mkdir -p $FASTQ_DIR
    wget -P $FASTQ_DIR ftp://ngs.sanger.ac.uk/production/gencode/rgasp/RGASP1/inputdata/human_fastq/GM12878_2x75_split.tgz
    tar --directory $FASTQ_DIR -xzf $FASTQ_DIR/GM12878_2x75_split.tgz
    find $FASTQ_DIR/GM12878_2x75_split -name "GM12878_2x75_rep[1-2].lane[1-3]_1.fq" -exec cat {} \; > $FASTQ_DIR/rna_1.fq
    gzip $FASTQ_DIR/rna_1.fq
    find $FASTQ_DIR/GM12878_2x75_split -name "GM12878_2x75_rep[1-2].lane[1-3]_2.fq" -exec cat {} \; > $FASTQ_DIR/rna_2.fq
    gzip $FASTQ_DIR/rna_2.fq
    rm -r $FASTQ_DIR/GM12878_2x75_split

%apprun download-reference
    mkdir -p $REF_DIR
    wget -P $REF_DIR ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_human/release_25/gencode.v25.transcripts.fa.gz
    gzip -d $REF_DIR/gencode.v25.transcripts.fa.gz
    wget -P $REF_DIR ftp://ftp.ensembl.org/pub/release-85/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
    gzip -d $REF_DIR/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz


%apprun download-rtg
    # url info for AJtrio was taken from this url
    # https://raw.githubusercontent.com/genome-in-a-bottle/giab_data_indexes/master/AshkenazimTrio/sequence.index.AJtrio_Illumina_2x250bps_06012016
    mkdir -p $RTG_DIR

    ## THESE FILES HAVE BEEN MADE AVAILABLE BY FTP DOWNLOAD
    wget https://stanfordmedicine.box.com/shared/static/beky9c9u05xmljtgj4kq9iuik33xqtbq.gz -O $RTG_DIR/HG002.1.10M.fastq.gz
    wget https://stanfordmedicine.box.com/shared/static/isod88qhvfy11d3jlxy2hc1am3axhqg9.gz -O $RTG_DIR/HG002.2.10M.fastq.gz
    wget https://stanfordmedicine.box.com/shared/static/wu7kn19y16org4sxvp5r7nw25x3kcc18.gz -O $RTG_DIR/HG003.1.10M.fastq.gz
    wget https://stanfordmedicine.box.com/shared/static/o2cdwpn55nuw98kmoq5o0ci67ojz4647.gz -O $RTG_DIR/HG003.2.10M.fastq.gz
    wget https://stanfordmedicine.box.com/shared/static/sdufnqkmspj4r8sd1h1cskx5sge7t6c4.gz -O $RTG_DIR/HG004.1.10M.fastq.gz
    wget https://stanfordmedicine.box.com/shared/static/5h4t29utrxcg9hbyen4lf6v6qid251bk.gz -O $RTG_DIR/HG004.2.10M.fastq.gz


# =======================
# simulate reads
# =======================

%apphelp simulate-reads
    Optionally set any of the following environment variables (defaults shown)
    READS (100000000)
    READ_LEN (150)
    GENOME_SIZE (3400000000)


%appenv simulate-reads
    READS=${READS:-100000000}
    READ_LEN=${READ_LEN:-150}
    GENOME_SIZE=${GENOME_SIZE:-3400000000}
    export GENOME_SIZE READ_LEN READS

%appinstall simulate-reads   
    wget https://www.niehs.nih.gov/research/resources/assets/docs/artbinmountrainier20160605linux64tgz.tgz
    tar -xzvf artbinmountrainier20160605linux64tgz.tgz 
    mv art_bin_MountRainier/* bin/
    chmod u+x bin/art_*

%apprun simulate-reads
    GENOME="$REF_DIR/Homo_sapiens.GRCh38.dna.primary_assembly.fa"
    FOLD_COVERAGE=$(python -c "print($READS*$READ_LEN/$GENOME_SIZE)")
    art_illumina --rndSeed 1 --in $GENOME --paired --len 75 --fcov $FOLD_COVERAGE --seqSys HS25 --mflen 500 --sdev 20 --noALN --out $FASTQ_DIR/dna_ && gzip $FASTQ_DIR/dna_1.fq && gzip $FASTQ_DIR/dna_2.fq


# =======================
# quantify transcripts
# =======================

%appinstall transcript
    cd /scif/apps && rm -rf transcript
    wget http://repo.continuum.io/archive/Anaconda3-4.1.1-Linux-x86_64.sh
    bash Anaconda3-4.1.1-Linux-x86_64.sh -b -p ./transcript
    rm Anaconda3-4.1.1-Linux-x86_64.sh && cd transcript
    bin/conda update -y conda
    bin/conda update -y anaconda
    bin/conda config --add channels bioconda
    bin/conda install -y --channel bioconda kallisto
    bin/conda clean -y --all

%apprun transcript
    kallisto index $REF_DIR/gencode.v25.transcripts.fa -i $REF_DIR/kallisto_index
    OUT_DIR=${SINGULARITY_APPDATA}/rna # /scif/data/transcript
    mkdir -p $OUT_DIR
    kallisto quant -b 100 --seed=1 --plaintext -t $NUMCORES -i $DATADIR/Reference/kallisto_index $DATADIR/Fastq/rna_1.fq.gz $DATADIR/Fastq/rna_2.fq.gz -o $OUT_DIR


# =======================
# bwa index and align
# =======================

%appinstall bwa-index-align
    git clone https://github.com/lh3/bwa.git build
    cd build && git checkout v0.7.15 && make
    mv -t ../bin bwa bwakit

    apt-get install -y liblzma-dev
    cd .. && wget https://github.com/samtools/samtools/releases/download/1.5/samtools-1.5.tar.bz2
    tar -xvjf samtools-1.5.tar.bz2
    cd samtools-1.5 && ./configure --prefix=${SINGULARITY_APPROOT}
    make && make install

%apprun bwa-index-align
    mkdir -p $DATADIR/Bam
    bwa index -a bwtsw $DATADIR/Reference/Homo_sapiens.GRCh38.dna.primary_assembly.fa
    bwa mem -t $NUMCORES $DATADIR/Reference/Homo_sapiens.GRCh38.dna.primary_assembly.fa $DATADIR/Fastq/dna_1.fq.gz $DATADIR/Fastq/dna_2.fq.gz | samtools view -bhS - > $DATADIR/Bam/container.bam  

%applabels bwa-index-align
    bwa-version v0.7.15
    samtools-version v1.5


# =======================
# rtg
# =======================

%appinstall run-rtg
    wget https://github.com/RealTimeGenomics/rtg-core/releases/download/3.6.2/rtg-core-non-commercial-3.6.2-linux-x64.zip
    unzip rtg-core-non-commercial-3.6.2-linux-x64.zip
    mv rtg-core-non-commercial-3.6.2/* bin/

%appenv run-rtg
    MEM=${MEM:-4g}
    THREADS=${THREADS:2}
    export MEM THREADS

%applabel run-rtg
    rtg-version 3.6.2

%apprun run-rtg
    REFERENCE=$DATADIR/Reference/Homo_sapiens.GRCh38.dna.primary_assembly.fa
    rtg format --format fasta --output=$REFERENCE.sdf $REFERENCE
    parallel --jobs 1 --xapply rtg RTG_MEM=$MEM map --format fastq --quality-format sanger --template $REFERENCE.sdf --output $RTG_DIR/container.{1} --left $OUT_DIR/{1}.1.10M.fastq.gz --right $OUT_DIR/{1}.2.10M.fastq.gz --sam-rg {2} --threads $THREADS ::: HG002 HG003 HG004 :::  "@RG\tID:HG002\tSM:NA24385\tPL:ILLUMINA" "@RG\tID:HG003\tSM:NA24149\tPL:ILLUMINA" "@RG\tID:HG004\tSM:NA24143\tPL:ILLUMINA"

    rtg RTG_MEM=$MEM family \
	--output $RTG_DIR/container.trio \
	--template $REFERENCE.sdf \
	--machine-errors illumina \
	--avr-model illumina-wgs.avr \
	--threads $THREADS \
	--son NA24385 \
	--father NA24149 \
	--mother NA24143 \
	$RTG_DIR/container.HG002/alignments.bam \
	$RTG_DIR/container.HG003/alignments.bam \
	$RTG_DIR/container.HG004/alignments.bam
