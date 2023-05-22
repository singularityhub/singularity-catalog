from: debian:latest
bootstrap: docker

# Install necessary linux packages from apt-get
%post
  apt-get update && apt-get install -y eatmydata

  eatmydata apt-get install -y wget bzip2 ca-certificates \
      libglib2.0-0 libxext6 libsm6 libxrender1 \
      git \
      libfreetype6-dev \
      swig \
      mpich \
      pkg-config \
      gcc \
      wget \
      curl \
      vim \
      nano \
      libgl1-mesa-glx \
      ffmpeg \
      fonts-liberation

  # Make folders necessary to play nice with Discovery
  mkdir -p /afs /inbox /ihome /opt /idata /dartfs-hpc/scratch/mind_hackathon /admin
  chmod a+rX /afs /inbox /ihome /opt /idata /admin
  chmod a+rX -R /opt /dartfs-hpc
  
  # Install anaconda
  echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
      wget --quiet https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh -O ~/anaconda.sh && \
      /bin/bash ~/anaconda.sh -b -p /opt/conda && \
      rm ~/anaconda.sh

  # Setup anaconda path
  export PATH="/opt/conda/bin:$PATH"
  conda install -y gcc

  # Install packages needed
  pip install git+https://github.com/IntelPNI/brainiak \
      nltools \
      nilearn \
      hypertools \
      pymvpa2 \
      mne \
      deepdish \
      nelpy \
      dask \
      pynv \
      seaborn

%environment
  PATH="/opt/conda/bin:$PATH"

%runscript
  echo "Welcome MIND travelers. Be warned: the singularity is near..."
  exec /bin/bash
