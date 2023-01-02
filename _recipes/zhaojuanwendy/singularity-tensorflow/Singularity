BootStrap:docker
From:tensorflow/tensorflow:latest-gpu

%runscript
  exec python "$@" 

%post
  # Enables access to ACCRE storage
  mkdir /scratch /data /gpfs22 /gpfs23 /dors

%test
  python -V
