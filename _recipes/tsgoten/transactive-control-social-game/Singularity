Bootstrap: docker
From: pytorch/pytorch:1.2-cuda10.0-cudnn7-devel

%files
  requirements.txt

%post
  apt-get update && apt-get install -y libglib2.0-0 libgl1-mesa-glx
  pip install --upgrade pip
  pip install -r requirements.txt
