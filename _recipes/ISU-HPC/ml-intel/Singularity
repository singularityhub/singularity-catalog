bootstrap: shub
from: ISU-HPC/machine-learning

%labels

AUTHOR Yasasvy Nanyam ynanyam@iastate.edu


%post


# ADD Intel python bindings

yum-config-manager --add-repo https://yum.repos.intel.com/setup/intelproducts.repo

rpm --import https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB

yum install -y intel-mkl intelpython2 intelpython3

yum clean all

