Bootstrap: docker
From: neurodebian

%environment
    PATH="/usr/local/anaconda/bin:$PATH"
%post
    # install debian packages
    apt-get update
    apt-get install -y eatmydata
    eatmydata apt-get install -y wget bzip2 \
      ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 \
      git git-annex-standalone gcc
    apt-get clean

    # install anaconda
    if [ ! -d /usr/local/anaconda ]; then
         wget https://repo.continuum.io/miniconda/Miniconda2-4.3.14-Linux-x86_64.sh \
            -O ~/anaconda.sh && \
         bash ~/anaconda.sh -b -p /usr/local/anaconda && \
         rm ~/anaconda.sh
    fi
    # set anaconda path
    export PATH="/usr/local/anaconda/bin:$PATH"

    # install the bare minimum
    conda install\
      numpy scipy matplotlib pandas seaborn
    conda clean --tarballs
    # install psychopy
    pip install pyopengl pyglet pillow moviepy lxml \
        openpyxl xlrd configobj pyyaml gevent greenlet \
        msgpack-python psutil tables requests[security] \
        pyosf cffi pysoundcard pysoundfile seaborn \
        psychopy_ext python-bidi psychopy
    pip install pyserial pyparallel 

%runscript
	echo "We're now inside the container"
