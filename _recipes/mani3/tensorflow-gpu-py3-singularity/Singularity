Bootstrap: docker
From: tensorflow/tensorflow:2.1.0-gpu-py3

%post
    apt-get update && apt-get install -y --no-install-recommends \
        curl \
        unzip \
        git \
        openssl \
        ca-certificates \
        protobuf-compiler \
        && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

    /usr/local/bin/pip3 --no-cache-dir install \
        wheel \
        Pillow \
        opencv-python \
        matplotlib \
        numpy \
        pandas \
        scipy \
        sklearn \
        tqdm \
        argparse \
        boto3 \
        mtcnn \
        Cython \
        contextlib2 \
        lxml \
        easydict \
        kaggle \
        seaborn \
        tensorflow-addons \
        tensorflow-datasets \
        pyarrow \
        imgaug \
        gspread \
        oauth2client \
        mlflow \
        jupyter


%environment
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8
    export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"
