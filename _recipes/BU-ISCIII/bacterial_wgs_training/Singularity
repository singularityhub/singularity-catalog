Bootstrap: docker
From: buisciii/centos7_base_image:latest

%files
	./scif_app_recipes/ /opt/
%post
	echo "Install basic development tools"
	yum -y groupinstall "Development Tools"
	yum -y update && yum -y install wget curl openssl-devel geos-devel udunits2-devel libxml2-devel cairo-devel libgit2-devel


	echo "Install python2.7 setuptools and pip"
	yum -y install python-setuptools
	easy_install pip

	echo "Installing SCI-F"
    pip install scif

    echo "Installing FastQC app" && \
    scif install /opt/scif_app_recipes/fastqc_v0.11.7_centos7.scif
    echo "Installing trimmomatic app" && \
    scif install /opt/scif_app_recipes/trimmomatic_v0.38_centos7.scif && \
    echo "Installing samtools app" && \
    scif install /opt/scif_app_recipes/samtools_v1.2_centos7.scif && \
    echo "Installing htslib app" && \
    scif install /opt/scif_app_recipes/htslib_v1.9_centos7.scif && \
    echo "Installing picard app" && \
    scif install /opt/scif_app_recipes/picard_v1.140_centos7.scif && \
    echo "Installing spades app" && \
    scif install /opt/scif_app_recipes/spades_v3.8.0_centos7.scif && \
    echo "Installing prokka app" && \
    scif install /opt/scif_app_recipes/prokka_v1.14.0_centos7.scif && \
    echo "Installing quast app" && \
    scif install /opt/scif_app_recipes/quast_v5.0.0_centos7.scif && \
    echo "Installing multiqc app" && \
    scif install /opt/scif_app_recipes/multiqc_v1.4_centos7.scif && \
    echo "Installing bwa app" && \
    scif install /opt/scif_app_recipes/bwa_v0.7.17_centos7.scif && \
    echo "Installing chewbbaca app" && \
    scif install /opt/scif_app_recipes/chewbbaca_v2.0.5_centos7.scif && \
    echo "Installing outbreaker app" && \
    scif install /opt/scif_app_recipes/outbreaker_v1.1_centos7.scif && \
    echo "Installing get_homologues app" && \
    scif install /opt/scif_app_recipes/gethomologues_v3.1.4_centos7.scif && \
    echo "Installing Unicycler app" && \
    scif install /opt/scif_app_recipes/unicycler_v0.4.7_centos7.scif && \
    echo "Installing Taranis app" && \
    scif install /opt/scif_app_recipes/taranis_v0.3.3_centos7.scif && \
    echo "Installing Download bigsdb api app" && \
    scif install /opt/scif_app_recipes/bigsdbdownload_v0.1_centos7.scif && \
    echo "Installing plasmidID app" && \
    scif install /opt/scif_app_recipes/plasmidid_v1.4.2_centos7.scif

	# Executables must be exported for nextflow, if you use their singularity native integration.
    # It would be cool to use $SCIF_APPBIN_bwa variable, but it must be set after PATH variable, because I tried to use it here and in %environment without success.
    find /scif/apps -maxdepth 2 -name "bin" | while read in; do echo "export PATH=\${PATH}:$in" >> $SINGULARITY_ENVIRONMENT;done

	find /scif/apps -maxdepth 2 -name "lib" | while read in; do echo "export LD_LIBRARY_PATH=\${LD_LIBRARY_PATH}:$in" >> $SINGULARITY_ENVIRONMENT ;done

	if [[ ":$PATH:" == *":/scif/apps/snppipeline:"* ]];then

		export CLASSPATH=/scif/apps/varscan/varscan-2.3.9/varscan-2.3.9.jar:$CLASSPATH >> $SINGULARITY_ENVIRONMENT
		export CLASSPATH=/scif/apps/picard/picard.jar:$CLASSPATH >> $SINGULARITY_ENVIRONMENT
		export CLASSPATH=/scif/apps/gatk/gatk-3.8/GenomeAnalysisTK.jar:$CLASSPATH >> $SINGULARITY_ENVIRONMENT

	fi

	## R packages

	# Install core R dependencies
	echo "r <- getOption('repos'); r['CRAN'] <- 'https://ftp.acc.umu.se/mirror/CRAN/'; options(repos = r);" > ~/.Rprofile && \
	Rscript -e "install.packages('ggplot2',dependencies=TRUE,lib='/usr/local/lib64/R/library')" && \
	Rscript -e "install.packages('ape',dependencies=TRUE,lib='/usr/local/lib64/R/library')" && \
	Rscript -e "source('https://bioconductor.org/biocLite.R');biocLite('ggtree',dependencies=TRUE,lib='/usr/local/lib64/R/library')" && \
	Rscript -e "install.packages('tidyr',dependencies=TRUE,lib='/usr/local/lib64/R/library')" && \
	Rscript -e "install.packages('plyr',dependencies=TRUE,lib='/usr/local/lib64/R/library')"

%runscript
    exec scif "$@"
