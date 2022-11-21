Bootstrap: docker
From: ubuntu:22.04

%setup
  mkdir -p ${SINGULARITY_ROOTFS}/tmp2/cat12_app

%files 
    env.yml /tmp2/env.yml
    pyproject.toml /tmp2/cat12_app    
    README.md /tmp2/cat12_app/
    src /tmp2/cat12_app/
    src/cat12_app/data/run_spm12.sh /tmp2/run_spm12.sh

%post -c /bin/bash

    apt-get update \
        && apt-get -y install unzip libxext6 libxt6 curl bzip2 wget \
        && apt-get clean \
        && apt-get autoremove \
        && rm -rf /var/lib/apt/lists/* /var/tmp/*
    
    export MAMBA_ROOT_PREFIX=/opt/conda
    curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
    eval "$(./bin/micromamba shell hook -s bash)"

    micromamba install --name base --quiet --yes --file /tmp2/env.yml  \
        && micromamba activate \
        && pip install --quiet /tmp2/cat12_app \
        && pip cache purge \
        && micromamba clean --all --yes \
        && rm -rf ~/.cache/pip/* \
        && rm -r /tmp2/cat12_app

    MCRROOT=/opt/mcr/v93
    MCR_INHIBIT_CTF_LOCK=1
    MATLAB_VERSION=R2017b
    CAT_VERSION=12.8.1
    CAT_REVISION=r2042
    CAT_FULLVERSION=CAT${CAT_VERSION}_${CAT_REVISION}
    SPMROOT=/opt/${CAT_FULLVERSION}_${MATLAB_VERSION}_MCR_Linux

    mkdir /tmp2/mcr_install \
        && wget -q -P /tmp2/mcr_install https://ssd.mathworks.com/supportfiles/downloads/${MATLAB_VERSION}/deployment_files/${MATLAB_VERSION}/installers/glnxa64/MCR_${MATLAB_VERSION}_glnxa64_installer.zip \
        && unzip -q /tmp2/mcr_install/MCR_${MATLAB_VERSION}_glnxa64_installer.zip -d /tmp2/mcr_install \
        && rm /tmp2/mcr_install/*zip \
        && /tmp2/mcr_install/install -destinationFolder ${MCRROOT} -agreeToLicense yes -mode silent \
        && rm -r /tmp2/mcr_install  \
        && wget -q -P /tmp2 http://www.neuro.uni-jena.de/cat12/${CAT_FULLVERSION}_${MATLAB_VERSION}_MCR_Linux.zip \
        && unzip -q /tmp2/${CAT_FULLVERSION}_${MATLAB_VERSION}_MCR_Linux.zip -d /opt \
        && rm /tmp2/${CAT_FULLVERSION}_${MATLAB_VERSION}_MCR_Linux.zip \
        && mv /tmp2/run_spm12.sh ${SPMROOT}/ \
        && chmod a+x ${SPMROOT}/run_spm12.sh \
        && ${SPMROOT}/run_spm12.sh ${MCRROOT} --version \
        && chmod -R a+x ${SPMROOT} \
        && cp -l ${SPMROOT}/standalone/cat_standalone.sh /usr/local/bin/ 
    
    rm -r /tmp2
    rm -rf /tmp/mathworks*

%environment
    export SPMROOT=/opt/CAT12.8.1_r2042_R2017b_MCR_Linux
    export MCRROOT=/opt/mcr/v93
    export MCR_INHIBIT_CTF_LOCK=1
    export MAMBA_ROOT_PREFIX=/opt/conda

%runscript
    eval "$(micromamba shell hook --shell=posix)"
    micromamba activate /opt/conda
    cat12 "$@"
