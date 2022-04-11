Bootstrap: docker
From: fermilab/fnal-wn-sl7

%post
   yum install -y freetype-devel git gitflow wget curl-devel redhat-lsb-core openssh-clients curl-devel libxml2-devel mesa-libGLU-devel  libSM-devel openssl-devel
  mkdir /products
  mkdir /software 
  wget http://scisoft.fnal.gov/scisoft/bundles/tools/pullProducts
  chmod +x pullProducts
  ./pullProducts /products slf7 uboone-v09_00_00 s97-e19 prof
  rm *.tar.bz2
  cd /software 
  git clone https://github.com/lmlepin9/SUPERA-uboone.git
  git clone https://github.com/DeepLearnPhysics/larcv3.git
  cd 
  source /products/setup 
  setup uboonecode v09_00_00 -q e19:prof 
  unsetup larlite -j -j 
  cd /software
  python -m venv ubcode 
  unset PYTHONPATH
  source ./ubcode/bin/activate
  pip install numpy 
  pip install scikit-build 
  pip install pytest 
  cd larcv3 
  git submodule update --init 
  python setup.py build -j 4
  python setup.py install 
  cd ..
  cd ./SUPERA-uboone
  export GALLERY_FMWK_CXX=h5c++
  source config/setup.sh
  make -j 4
  export LD_LIBRARY_PATH=$(python -c "import larcv; print(larcv.get_lib_dir())"):$LD_LIBRARY_PATH
  
%environment
