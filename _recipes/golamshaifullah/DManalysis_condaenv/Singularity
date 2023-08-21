BootStrap: docker
From: continuumio/anaconda3

%setup 
     mkdir -p ${SINGULARITY_ROOTFS}/opt/specfiles
%files
     DM.spec /opt/specfiles/DM.spec
%runscript

     echo "Starting notebook..."
     echo "Open browser to localhost:8888"
     exec /opt/conda/bin/conda activate DMenv
     exec /opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --allow-root --port=8888 --no-browser

%post
     # Build a DM env
     /opt/conda/bin/conda create --name DMenv --file /opt/specfiles/DM.spec
     # Install jupyter notebook
     /opt/conda/bin/conda install jupyter -y --quiet 
     mkdir /opt/notebooks
     apt-get autoremove -y
     apt-get clean
