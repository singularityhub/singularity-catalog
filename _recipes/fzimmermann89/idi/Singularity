bootstrap: docker
from: nvidia/cuda:12.8.1-devel-ubuntu20.04




%help
IDI jupyterhub (Cuda 12)


%environment
CUDA_ROOT=/usr/local/cuda
export CUDA_ROOT

SINGULARITY_SHELL=/bin/zsh
export SINGULARITY_SHELL

PATH=$PATH:/opt/anaconda3/bin:/usr/local/cuda/bin
export PATH

LD_PRELOAD=/usr/local/lib/mklpatch.so
export LD_PRELOAD

SHELL=/usr/bin/zsh
export SHELL

MKL_THREADING_LAYER=gnu
export MKL_THREADING_LAYER

CONDA_PKGS_DIRS=/tmp
export CONDA_PKGS_DIRS



%post
apt-get update && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends aria2 curl git gzip lz4 p7zip-full p7zip-rar \
  rsync unzip wget xz-utils zip openssl bzip2 axel binutils cmake diffutils \
  elfutils file build-essential gdb htop less libstdc++6 ltrace make mc mosh \
  openmpi-bin libopenmpi-dev openssh-client patch patchutils linux-tools-common \
  linux-tools-generic psmisc screen strace tmux vim zsh libssl-dev munge \
  imagemagick slurm-wlm \
&& rm -rf /var/lib/apt/lists/*


#miniconda
echo "installing conda"
wget -O /tmp/Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
cd /tmp/ && bash /tmp/Miniforge3.sh -b -p /opt/conda
rm /tmp/Miniforge3.sh
ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh
PATH=$PATH:/usr/local/cuda/bin:/opt/conda/bin

#conda env
. /etc/profile.d/conda.sh
echo "installing conda extensions"
conda activate
mamba install -q -y "python=3.11"  "numexpr>=2.7.2" "numpy>=1.17" h5py scipy numba "mkl>=2020" cython  "jupyterlab" jupyter scikit-image scikit-learn seaborn pandas line_profiler black ninja memory_profiler isort "mkl-include>=2020" cmake sympy pytest lmfit pytest-flake8 ruff "numpy<2.2" matplotlib tqdm cython mkl-devel mkl-service "setuptools<60" einops uv joblib
conda clean -a -y &

echo 'installing pnumpy from pip' && pip install pnumpy
echo "installing pycuda from pip" && CFLAGS=-std=c++11 CXXFLAGS=-std=c++11  LIBRARY_PATH=/usr/local/cuda/lib64/stubs CPATH=/usr/local/cuda/include CUDA_ROOT=/usr/local/cuda pip install pycuda
echo 'installing cupy from pip' && pip install cupy-cuda12x &

#conda config
conda config  --file /opt/conda/.condarc --set changeps1 False
conda config  --file /opt/conda/.condarc --set auto_activate_base true

cat > /etc/profile.d/zconda.sh << "EOF1"
#. /etc/profile.d/conda.sh
conda activate
EOF1

cat > /opt/runscript.sh << "EOF2"
#!/bin/bash
. /etc/profile.d/conda.sh
conda activate
exec "$@"
EOF2
chmod +x /opt/runscript.sh


#patch for mkl
echo 'compiling mkl patch'
cat > /tmp/mklpatch.c << "EOF4"
//https://danieldk.eu/Posts/2020-08-31-MKL-Zen.html
int mkl_serv_intel_cpu_true() {
  return 1;
}
EOF4
gcc -shared -fPIC -o /tmp/mklpatch.so /tmp/mklpatch.c
cp /tmp/mklpatch.so /usr/local/lib/mklpatch.so && chmod 775 /usr/local/lib/mklpatch.so && echo 'done'



#idi
wait
echo 'install idi' && pip install git+https://github.com/fzimmermann89/idi


#cleanup
wait
conda clean -a -y -f
pip cache purge
jupyter lab clean
rm -rf /root/.conda | true
rm -rf /root/.npm | true
rm -rf /root/.cache | true
rm -rf /tmp/npm* | true
rm -rf /tmp/yarn* | true
rm -rf /var/cache/* | true
touch /INSIDE_SINGULARITY_IDI_IMAGE
echo '####ALL DONE####'

#slurm user
#useradd -r --shell /usr/sbin/nologin slurm


%labels
    Maintainer zimmf
    Version 0.2
        
%runscript
exec /opt/runscript.sh python "$@"

%startscript
exec /opt/runscript.sh jupyter lab "$@"

%apprun jupyter
exec /opt/runscript.sh jupyter "$@"

%apprun ipython
exec /opt/runscript.sh ipython "$@"

