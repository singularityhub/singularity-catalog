Bootstrap: shub
From: bstriner/cuda-10.1-cudnn7-devel-ubuntu16.04
#tensorflow-cuda-10.1-cudnn7-devel-ubuntu16.04
%post
    apt-get install -y python3 python3-dev python3-pip
    python3 -m pip install --upgrade pip
    python3 -m pip install --upgrade setuptools wheel cython
    python3 -m pip install --upgrade tf-nightly-xla-gpu tf-estimator-nightly tfp-nightly tb-nightly numpy h5py dill matplotlib mock
    #python3 -m pip uninstall -y protobuf
    #python3 -m pip uninstall -y protobuf
    python3 -m pip install protobuf==3.8.0
    python3 -m pip install tqdm
    python3 -c "import tensorflow"
    #rm -Rf /usr/local/lib/python3.5/dist-packages/tensorflow_core/_api/v1/compat/v1/test
    #mkdir /usr/local/lib/python3.5/dist-packages/tensorflow_core/_api/v1/compat/v1/test
    #touch /usr/local/lib/python3.5/dist-packages/tensorflow_core/_api/v1/test/__init__.py
    #sed -i "s/from tensorflow.python.platform.googletest import mock/import mock/" "/usr/local/lib/python3.5/dist-packages/tensorflow_core/_api/v1/test/__init__.py"
    #python3 -c "import tensorflow"
