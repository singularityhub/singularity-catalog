Bootstrap: docker
From: conda/miniconda3-centos7:latest

%setup

%files
    files/ /opt/benchmark

%apprun inspiral
    mkdir -p /dev/shm/benchmark
    cp -r /opt/benchmark  /dev/shm/.
    echo "Running inspiral benchmark"
    sh /dev/shm/benchmark/run_inspiral.sh

%apprun pe
    mkdir -p /dev/shm/benchmark
    cp -r /opt/benchmark  /dev/shm/.
    echo "Running BBH pe"
    sh /dev/shm/benchmark/run_bbh_pe.sh

%post
yum install -y time bc
yum -y groupinstall "Development Tools" "Development Libraries"
conda config --add channels conda-forge
conda install pycbc
