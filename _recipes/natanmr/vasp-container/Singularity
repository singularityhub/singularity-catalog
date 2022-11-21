Bootstrap: docker
From:ufscar/ubuntu_ompi:latest

%help
Container of VASP and Wannier90 using intel oneapi. Author: Natan Moreira Regis (natan.moreira.regis12@gmail.com). Last update: 19 Nov 2022

%files
/home/natan/estudos/programs/vasp/vasp.5.4.4.tar.gz /opt/

%post
 
# Install oneapt stuffs
echo "install oneapi" 
apt update 
apt-get install gnupg2 -y
wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor | tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ACFA9FC57E6C5DBE
apt update 
apt --allow-unauthenticated install intel-hpckit -y
apt install rsync -y

# Source oneapi
# Primeira opção:
. /opt/intel/oneapi/setvars.sh intel64
# Segunda opção
source /opt/intel/oneapi/setvars.sh intel64


#Compile vasp
echo "Compile VASP 5.4.4"
tar -xf /opt/vasp.5.4.4.tar.gz -C /opt/
rm /opt/vasp.5.4.4.tar.gz
mv /opt/vasp_2 /opt/vasp.5.4.4
cd /opt/vasp.5.4.4
make all
 
echo "Compilation of programs complete!!!!"

%runscript
	
%test
