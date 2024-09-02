# Author: B. Anderson
# Singularity recipe for creating a container for using NCBI SRA tools


Bootstrap: docker
From: ncbi/sra-tools:latest


%help
	This container is for running the SRA Toolkit
	To use: singularity exec SRA.sif [command] [args]


%labels
	MAINTAINER bmichanderson
	PROGRAM SRA Toolkit
	VERSION latest


%post


%environment


%runscript

