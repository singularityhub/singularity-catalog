Bootstrap: docker
From: ubuntu:20.04

%help
	Info and usage: /opt/pipeline/README.md

%setup
  # Create an installation directory for the codebase. We can often finagle this
  # in the 'files' section and forgo the 'setup' section entirely, but it's 
  # clearer this way.
  mkdir -p "${SINGULARITY_ROOTFS}"/opt/pipeline

%files
  # Used to copy files into the container
  examcard2txt 		  /opt/pipeline
  README.md        /opt/pipeline
  dcm4che-2.0.25    /opt/dcm4che-2.0.25


%environment
  export LANG=en_US.UTF-8
  export LC_ALL=C.UTF-8 
  export LANGUAGE=en_US.UTF-8
  # Add dcm4che to path
  PATH=/opt/dcm4che-2.0.25/bin:$PATH

%labels
  Maintainer r.dylan.lawless@vumc.org


%post
  
  # Install misc tools

  apt-get update 
  DEBIAN_FRONTEND=noninteractive \
  apt-get install -y --no-install-recommends \
    curl \
    bzip2 \
    make \
    perl \
    cpanminus \
    gcc \
    build-essential \
    openjdk-8-jdk \
    ant \
    wget \
    unzip \
    zip \
    python3 \
    python3-pip \
    python3-cffi \
    python3-brotli \
    libpango-1.0-0 \
    libharfbuzz0b \
    libpangoft2-1.0-0 \
    bc \
    libxml-libxml-perl \
    imagemagick \
    expat \
    libexpat1-dev \
    software-properties-common
  
  apt-get -y clean
  rm -rf /var/lib/apt/lists/*

  # Fix java certificate issues
  apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

  # Create a few directories to use as bind points when we run the container
  mkdir /INPUTS
  mkdir /OUTPUTS

  # Clean up unneeded packages and cache
  apt clean && apt -y autoremove

  # Set up Perl
  cpanm XML::Parser; rm -fr root/.cpanm

  # Install pip packages
  python3 -m pip --no-cache-dir install setuptools --upgrade
  python3 -m pip --no-cache-dir install lxml
  python3 -m pip --no-cache-dir install weasyprint

%runscript

  # We just call our entrypoint, passing along all the command line arguments 
  # that were given at the singularity run command line.
  /opt/pipeline/examcard2txt/run_examcard_conversion.sh "$@"
