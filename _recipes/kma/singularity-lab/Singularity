BootStrap: docker
From: ubuntu:xenial
 
%setup
    # commands to be executed on host outside container during bootstrap
    
%post
   # commands to be executed inside container during bootstrap
   
   # add universe repo and install some packages
    sed -i '/xenial.*universe/s/^#//g' /etc/apt/sources.list
   
   # locale-gen en_US.UTF-8
     export LC_ALL=C
 
    apt-get -y update
    apt-get -y install vim wget python python-pip
 
 
    # install pandas 
    pip install --upgrade pip
    pip install  pandas 
    pip install  matplotlib
    
    # create bind points for MesoFC HPC environment
    mkdir -p /Work
    mkdir -p /Home

%runscript
    # commands to be executed when the container runs
    exec python "$@"
 
%test
    # commands to be executed within container at close of bootstrap process
  
