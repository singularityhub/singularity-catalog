Bootstrap: docker
From: tensorflow/tensorflow:2.11.0-gpu
Stage: build

%post
    pip install ipython
    pip install tensorflow-addons
    pip install matplotlib==3.3.4
    pip install googleapis-common-protos==1.63.0
    pip install ray==2.9.3
    pip install https://github.com/huynhngoc/deoxys-image/archive/master.zip
    pip install https://github.com/huynhngoc/deoxys/archive/master.zip
    pip install scikit-image
    pip install scikit-learn
    pip install mypy
    pip install nptyping
    pip install elasticdeform
    pip install lifelines
    pip install scikit-survival
    pip install visualkeras
    pip install shap
    pip install lime
    pip install SimpleITK
    pip install pydicom

%environment
    export KERAS_MODE=TENSORFLOW
