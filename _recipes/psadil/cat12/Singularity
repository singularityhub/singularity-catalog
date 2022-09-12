Bootstrap: docker
From: ubuntu:22.04

%setup
  mkdir -p ${SINGULARITY_ROOTFS}/tmp2

%files 
  ./code/main /usr/local/bin/main
  ./CAT12.8.1_r2042_R2017b_MCR_Linux.zip /tmp2/CAT12.zip
  ./MCR_R2017b_glnxa64_installer.zip /tmp2/MCR_R2017b_glnxa64_installer.zip

%post
  apt-get update \
  && apt-get -y install unzip libxext6 libxt6 moreutils \
  && apt-get clean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/* /var/tmp/*

  SPMROOT=/opt/CAT12.8.1_r2042_R2017b_MCR_Linux
  MCRROOT=/opt/mcr
  MCR_INHIBIT_CTF_LOCK=1

  mkdir /tmp2/mcr_install \
    && unzip -q /tmp2/MCR_R2017b_glnxa64_installer.zip -d /tmp2/mcr_install \
    && unzip -q /tmp2/CAT12.zip -d /opt \
    && /tmp2/mcr_install/install -destinationFolder ${MCRROOT} -agreeToLicense yes -mode silent \
    && ${SPMROOT}/run_spm12.sh ${MCRROOT}/v93 --version \
    && chmod -R +x ${SPMROOT} \
    && cp -l ${SPMROOT}/standalone/cat_standalone.sh /usr/local/bin/ \
    && rm -r /tmp2

%environment
    export SPMROOT=/opt/CAT12.8.1_r2042_R2017b_MCR_Linux
    export MCRROOT=/opt/mcr/v93
    export MCR_INHIBIT_CTF_LOCK=1

%runscript
    exec /usr/local/bin/main "$@"


