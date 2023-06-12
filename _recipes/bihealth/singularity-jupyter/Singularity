BootStrap: docker
From: continuumio/anaconda3

%runscript

     echo "Starting notebook..."
     echo "Open browser to localhost:8888"
     exec /opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser --allow-root

%post

     # Install jupyter notebook and friends
     /opt/conda/bin/conda install -c conda-forge -y --quiet \
          jupyterlab notebook \
          pandas matplotlib scipy \
          scikit-learn scikit-learn-extra
     apt-get autoremove -y
     apt-get clean
