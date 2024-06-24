Bootstrap: docker
From: scientificlinux/sl:6

%post
  yum install -y freetype-devel git gitflow wget curl-devel redhat-lsb-core openssh-clients curl-devel libxml2-devel mesa-libGLU-devel libSM-devel openssl-devel
  mkdir /products
  wget http://scisoft.fnal.gov/scisoft/bundles/tools/pullProducts
  chmod +x pullProducts
  ./pullProducts /products slf6 uboone-v06_26_01_14 e10 prof
  rm *.tar.bz2

%environment
