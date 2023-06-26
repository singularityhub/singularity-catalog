Bootstrap: docker
From: python:2.7.14

%help
Hello. You are seeing the offical Singularity image of Granatum (for Python).

%files
    
%post
    apt-get -y update && apt-get -y install vim less
    pip install cmake
    pip install --no-cache-dir ipython scikit-learn scipy matplotlib numpy
    pip install --no-cache-dir bokeh colour hdbscan keras theano
    git clone https://github.com/DmitryUlyanov/Multicore-TSNE.git /tmp/Multicore-TSNE \
        && cd /tmp/Multicore-TSNE \
        && git reset --hard 682531fe21db7e10c1f7b0a783b7be86128273bc \
        && pip install .

%appfiles clustering
    ./granatum_clustering .
    ./granatum_clustering/ ./granatum_clustering
    ./granatum_deeplearning .
    ./granatum_deeplearning/ ./granatum_deeplearning

%appinstall clustering
    # cd ./granatum_clustering && pip install -r ./requirements.txt
    cd ./granatum_clustering && pip install -e .
    # cd ./granatum_deeplearning && pip install -r ./requirements.txt
    cd ./granatum_deeplearning && pip install -e .
    mkdir -p $HOME/.keras && cp ./granatum_deeplearning/keras.json $HOME/.keras/keras.json
    

%apprun clustering
    python clustering.py