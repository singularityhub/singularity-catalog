# Set base image
Bootstrap: docker
From: hariszaf/darn:latest

# Set the maintainer
%labels
   Maintainer Haris Zafeiropoulos

# Set Singularity environment
%post
   export WORKDIR="/home"
   echo "export WORKDIR=$WORKDIR" >> $SINGULARITY_ENVIRONMENT
   mkdir -p $WORKDIR
   echo "export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" >> $SINGULARITY_ENVIRONMENT 

# Set basecommnad; run PEMA analysis
%runscript
   bash /home/darn.sh "$@"

# Singularity container complete
