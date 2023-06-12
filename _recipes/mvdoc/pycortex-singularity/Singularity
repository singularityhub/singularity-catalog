bootstrap: docker
from: debian:jessie

%environment
  #PATH=/opt/afni:$PATH
  #PATH=/opt/ants:$PATH
  #PATH=/opt/c3d/bin:$PATH
  #PATH=/opt/fsl/bin:$PATH
  PATH=/opt/conda/bin:$PATH
  #PATH=/opt/mrtrix3/bin:$PATH
  C3DPATH=/opt/c3d
  #ANTSPATH=/opt/ants
  FREESURFER_HOME=/opt/freesurfer
  FSLDIR=/opt/fsl
  export PATH FREESURFER_HOME FSLDIR

%post

  #----------------------------------------------------------
  # Install common dependencies and create default entrypoint
  #----------------------------------------------------------
  export LANG="en_US.UTF-8"
  export LC_ALL="C.UTF-8"
  ND_ENTRYPOINT="/neurodocker/startup.sh"

  apt-get update -qq && apt-get install -yq --no-install-recommends  \
        apt-utils bzip2 ca-certificates curl locales unzip git \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
      && localedef --force --inputfile=en_US --charmap=UTF-8 C.UTF-8 \
      && chmod 777 /opt && chmod a+s /opt \
      && mkdir -p /neurodocker \
      && if [ ! -f "$ND_ENTRYPOINT" ]; then \
           echo '#!/usr/bin/env bash' >> $ND_ENTRYPOINT \
           && echo 'set +x' >> $ND_ENTRYPOINT \
           && echo 'if [ -z "$*" ]; then /usr/bin/env bash; else /usr/bin/env bash -c "$*"; fi' >> $ND_ENTRYPOINT; \
         fi \
      && chmod -R 777 /neurodocker && chmod a+s /neurodocker

  # Installing freesurfer
  curl -sSL https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.1/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.1.tar.gz | tar zxv --no-same-owner -C /opt \
      --exclude='freesurfer/trctrain' \
      --exclude='freesurfer/subjects/fsaverage_sym' \
      --exclude='freesurfer/subjects/fsaverage3' \
      --exclude='freesurfer/subjects/fsaverage4' \
      --exclude='freesurfer/subjects/cvs_avg35' \
      --exclude='freesurfer/subjects/cvs_avg35_inMNI152' \
      --exclude='freesurfer/subjects/bert' \
      --exclude='freesurfer/subjects/V1_average' \
      --exclude='freesurfer/average/mult-comp-cor' \
      --exclude='freesurfer/lib/cuda' \
      --exclude='freesurfer/lib/qt' \
  && sed -i '$isource $FREESURFER_HOME/SetUpFreeSurfer.sh' $ND_ENTRYPOINT
  #--------------------------
  # Install FreeSurfer v6.0.0
  #--------------------------
  # Install version minimized for recon-all
  # See https://github.com/freesurfer/freesurfer/issues/70
  #apt-get update -qq && apt-get install -yq --no-install-recommends bc libgomp1 libxmu6 libxt6 tcsh perl \
  #    && apt-get clean \
  #    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  #    && echo "Downloading minimized FreeSurfer ..." \
  #    && curl -sSL https://dl.dropbox.com/s/nnzcfttc41qvt31/recon-all-freesurfer6-3.min.tgz | tar xz -C /opt \
  #    && sed -i '$isource $FREESURFER_HOME/SetUpFreeSurfer.sh' $ND_ENTRYPOINT
  FREESURFER_HOME=/opt/freesurfer

  #--------------------------------------------------
  # Add NeuroDebian repository
  # Please note that some packages downloaded through
  # NeuroDebian may have restrictive licenses.
  #--------------------------------------------------
  apt-get update -qq && apt-get install -yq --no-install-recommends dirmngr gnupg \
      && curl -sSL http://neuro.debian.net/lists/jessie.us-nh.full \
      > /etc/apt/sources.list.d/neurodebian.sources.list \
      && curl -sSL https://dl.dropbox.com/s/zxs209o955q6vkg/neurodebian.gpg \
      | apt-key add - \
      && (apt-key adv --refresh-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9 || true) 

  # Install NeuroDebian packages
  apt-get update -qq \
      && apt-get install -yq inkscape gcc fsl-complete \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
      && sed -i '$isource /etc/fsl/fsl.sh' $ND_ENTRYPOINT

  #apt-get update -qq \
  #  && apt-get install -y -q --no-install-recommends git \
  #                                                   vim \
  #  && apt-get clean \
  #  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

  #------------------
  # Install Miniconda
  #------------------
  CONDA_DIR=/opt/conda
  PATH=/opt/conda/bin:$PATH
  echo "Downloading Miniconda installer ..." \
      && miniconda_installer=/tmp/miniconda.sh \
      && curl -sSL -o $miniconda_installer https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
      && /bin/bash $miniconda_installer -b -p $CONDA_DIR \
      && rm -f $miniconda_installer \
      && conda config --system --prepend channels conda-forge \
      && conda config --system --set auto_update_conda false \
      && conda config --system --set show_channel_urls true

  #-------------------------
  # Create conda environment
  #-------------------------
  # 3.6
  #conda create -y -q --name neuro36 --channel vida-nyu python=3.6 \
  #                                                       numpy \
  #                                                       pandas \
  #                                                       reprozip \
  #                                                       traits \
  #                                                       networkx \
  #                                                       jupyter \
  #                                                       seaborn \
  #                                                       libgcc \
  #    && sync && conda clean -tipsy && sync \
  #    && /bin/bash -c "source activate neuro36 \
  #      && pip install -q --no-cache-dir nipype dipy duecredit mne \
  #         git+https://github.com/mvdoc/pybids@fix/setup" \
  #    && sync
  # 2.7
  conda create -y -q --name neuro27 --channel vida-nyu python=2.7 \
                                                         numpy \
                                                         pandas \
                                                         reprozip \
                                                         traits \
                                                         networkx \
                                                         jupyter \
                                                         seaborn \
                                                         pymvpa2 \
                                                         libgcc \
                                                         cython \
                                                         mayavi \
                                                         traitsui \
      && conda clean -tipsy \
      && /bin/bash -c "source activate neuro27 \
        && pip install --no-cache-dir nipype dipy duecredit mne datalad pprocess Pillow \
        git+https://github.com/mvdoc/pybids@fix/setup" \
      && sed -i '$isource activate neuro27' $ND_ENTRYPOINT

  # Install pycortex and change default location of filestore
  if [ ! -d /src ]; then
     mkdir /src
  fi 

  cd /src && \
    git clone https://github.com/gallantlab/pycortex && \
    cd pycortex && \
    git checkout glrework-merged && \
    sed -i '/\[basic\]/a filestore=/cortex-filestore' cortex/defaults.cfg && \
    /bin/bash -c "source activate neuro27 && pip install -e ."

  # Make directories for use
  mkdir /ihome /idata /scratch /data /dartfs /dartfs-hpc /cortex-filestore


%runscript
  exec /neurodocker/startup.sh "$*"
