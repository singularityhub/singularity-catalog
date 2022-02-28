Bootstrap: docker
From: ubuntu:18.04

%setup
  mkdir -p ${SINGULARITY_ROOTFS}/downloads

%files 
  ./code/main /usr/local/bin/main
  ./CAT12.zip /downloads/CAT12.zip
  ./MCR_R2017b_glnxa64_installer.zip /downloads/MCR_R2017b_glnxa64_installer.zip

%post
    apt-get update
    apt-get -y install unzip libxext6 libxt6 moreutils
    apt-get clean
    apt-get autoremove

    mkdir /downloads/mcr_install \
      && unzip -q /downloads/MCR_R2017b_glnxa64_installer.zip -d /downloads/mcr_install \
      && rm /downloads/MCR_R2017b_glnxa64_installer.zip \
      && /downloads/mcr_install/install -destinationFolder /opt/mcr -agreeToLicense yes -mode silent \
      && rm -r /downloads/mcr_install 
    
    # install SPM
    unzip -q /downloads/CAT12.zip -d /downloads \
    && rm -r /downloads/CAT12.zip \
    && mv /downloads/standalone /opt/spm \
    && /opt/spm/run_spm12.sh /opt/mcr/v93 quit \
    && chmod +x /opt/spm/run_spm12.sh /opt/spm/spm12  \
    && cp /opt/spm/spm12_mcr/home/vm01/MATLAB/toolbox/spm12/toolbox/cat12/standalone/cat_standalone.sh /bin \
    && chmod +x /bin/cat_standalone.sh

    rm -rf /downloads

%environment
    export SPMROOT=/opt/spm
    export MCRROOT=/opt/mcr/v93
    export MCR_INHIBIT_CTF_LOCK=1

%runscript
    exec /code/main "$@"


