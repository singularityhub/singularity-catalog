bootstrap: docker
FROM: bioconductor/release_core2

%labels
AUTHOR Yasasvy Nanyam ynanyam@iastate.edu

%post
apt install -y python3-pip libreadline-dev libpcre3 libpcre3-dev lzma lzma-dev liblzma-dev bzip2 libbz2-dev
pip3 install --no-cache-dir https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.10.0rc0-cp35-cp35m-linux_x86_64.whl
pip3 install --no-cache-dir plasFlow
pip3 install --no-cache-dir biopython
# Setting required library paths
echo 'export LD_LIBRARY_PATH=/usr/local/lib/R/lib' >>$SINGULARITY_ENVIRONMENT
echo 'export TMPDIR=/local/scratch' >>$SINGULARITY_ENVIRONMENT

