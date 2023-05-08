Bootstrap: docker
From: twongjirad/docker-caffe-larbys-dlee-ssnet

%post
  echo "START POST SCRIPT"
  apt-get -y update
  apt-get -y install vim wget perl python python-pip python-dev
  cd /usr/local
  rm -rf gpu4singularity
  git clone https://github.com/twongjirad/gpu4singularity
  cd gpu4singularity
  chmod a+rx gpu4singularity
  echo "GPU 4 SINGULARITY"
  ./gpu4singularity --full-url=http://us.download.nvidia.com/XFree86/Linux-x86_64/375.39/NVIDIA-Linux-x86_64-375.39.run --nvidia-version 375.39
  cd ../
  rm -rf gpu4singularity
  apt-get autoremove -y
  apt-get clean -y  
  mkdir -p /cluster/home
  mkdir -p /cluster/kappa
  mkdir -p /cluster/shared
  mkdir -p /opt/shared