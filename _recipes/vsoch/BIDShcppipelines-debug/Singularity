Bootstrap: docker

From: ubuntu:trusty-20170119


%files
run.py /run.py
version /version
IntendedFor.py /IntendedFor.py
modified_files/fsl_sub /fsl_sub
modified_files/settings.sh /settings.sh
modified_files/PostFix.sh /PostFix.sh
modified_files/run_prepareICAs.sh /run_prepareICAs.sh
modified_files/RestingStateStats.sh /RestingStateStats.sh
modified_files/run_RestingStateStats.sh /run_RestingStateStats.sh
modified_files/run_ComputeVN.sh /run_ComputeVN.sh
modified_files/MSMAllPipeline.sh /MSMAllPipeline.sh
modified_files/MSMAll.sh /MSMAll.sh
modified_files/generate_level1_fsf.sh /generate_level1_fsf.sh
modified_files/hcp_fix_multi_run /hcp_fix_multi_run

%environment
export CARET7DIR=/opt/workbench/bin_rh_linux64
export HCPPIPEDIR=/opt/HCP-Pipelines
export HCPPIPEDIR_Templates=/opt/HCP-Pipelines/global/templates
export HCPPIPEDIR_Bin=/opt/HCP-Pipelines/global/binaries
export HCPPIPEDIR_Config=/opt/HCP-Pipelines/global/config
export HCPPIPEDIR_PreFS=/opt/HCP-Pipelines/PreFreeSurfer/scripts
export HCPPIPEDIR_FS=/opt/HCP-Pipelines/FreeSurfer/scripts
export HCPPIPEDIR_PostFS=/opt/HCP-Pipelines/PostFreeSurfer/scripts
export HCPPIPEDIR_fMRISurf=/opt/HCP-Pipelines/fMRISurface/scripts
export HCPPIPEDIR_fMRIVol=/opt/HCP-Pipelines/fMRIVolume/scripts
export HCPPIPEDIR_tfMRI=/opt/HCP-Pipelines/tfMRI/scripts
export HCPPIPEDIR_dMRI=/opt/HCP-Pipelines/DiffusionPreprocessing/scripts
export HCPPIPEDIR_dMRITract=/opt/HCP-Pipelines/DiffusionTractography/scripts
export HCPPIPEDIR_Global=/opt/HCP-Pipelines/global/scripts
export HCPPIPEDIR_tfMRIAnalysis=/opt/HCP-Pipelines/TaskfMRIAnalysis/scripts
export MSMBin=/opt/HCP-Pipelines/MSMBinaries
export MSMBINDIR=${MSMBin}
export MSMCONFIGDIR=/opt/HCP-Pipelines/MSMConfig
export OS=Linux
export FS_OVERRIDE=0
export FIX_VERTEX_AREA=
export SUBJECTS_DIR=/opt/freesurfer/subjects
export FSF_OUTPUT_FORMAT=nii.gz
export MNI_DIR=/opt/freesurfer/mni
export LOCAL_DIR=/opt/freesurfer/local
export FREESURFER_HOME=/opt/freesurfer
export FSFAST_HOME=/opt/freesurfer/fsfast
export MINC_BIN_DIR=/opt/freesurfer/mni/bin
export MINC_LIB_DIR=/opt/freesurfer/mni/lib
export MNI_DATAPATH=/opt/freesurfer/mni/data
export FMRI_ANALYSIS_DIR=/opt/freesurfer/fsfast
export PERL5LIB=/opt/freesurfer/mni/lib/perl5/5.8.5
export MNI_PERL5LIB=/opt/freesurfer/mni/lib/perl5/5.8.5
export PATH=/opt/freesurfer/bin:/opt/freesurfer/fsfast/bin:/opt/freesurfer/tktools:/opt/freesurfer/mni/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
export PYTHONPATH=""
export FSL_FIXDIR=/opt/fix
export FSLDIR=/usr/share/fsl/5.0
export FSL_DIR="${FSLDIR}"
export FSLOUTPUTTYPE=NIFTI_GZ
export PATH=/usr/lib/fsl/5.0:$PATH
export FSLMULTIFILEQUIT=TRUE
export POSSUMDIR=/usr/share/fsl/5.0
export LD_LIBRARY_PATH=/usr/lib/fsl/5.0
export FSLTCLSH=/usr/bin/tclsh
export FSLWISH=/usr/bin/wish
export FSLOUTPUTTYPE=NIFTI_GZ

%post
# Make script executable
chmod +x /run.py

# Make local folders
mkdir /share
mkdir /scratch
mkdir /local-scratch
mkdir /bids_dir
mkdir /output_dir
mkdir /fsf_template_dir

#create 360CortSurf_19Vol_parcel.dlabel.nii
apt-get -y update
apt-get install -y wget
cd /
wget https://github.umn.edu/hendr522/HCPPipelines/blob/master/modified_files/360CortSurf_19Vol_parcel.dlabel.nii
apt-get -qq update
apt-get install -yq --no-install-recommends bc bzip2 ca-certificates curl libgomp1 perl-modules tar tcsh wget unzip git
cd /opt
git clone https://github.com/circulosmeos/gdown.pl.git

# Download FreeSurfer
wget -qO- ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/5.3.0-HCP/freesurfer-Linux-centos4_x86_64-stable-pub-v5.3.0-HCP.tar.gz | tar zxv -C /opt \
    --exclude='freesurfer/trctrain' \
    --exclude='freesurfer/subjects/fsaverage_sym' \
    --exclude='freesurfer/subjects/fsaverage3' \
    --exclude='freesurfer/subjects/fsaverage4' \
    --exclude='freesurfer/subjects/fsaverage5' \
    --exclude='freesurfer/subjects/fsaverage6' \
    --exclude='freesurfer/subjects/cvs_avg35' \
    --exclude='freesurfer/subjects/cvs_avg35_inMNI152' \
    --exclude='freesurfer/subjects/bert' \
    --exclude='freesurfer/subjects/V1_average' \
    --exclude='freesurfer/average/mult-comp-cor' \
    --exclude='freesurfer/lib/cuda' \
    --exclude='freesurfer/lib/qt'
apt-get install -y tcsh bc tar libgomp1 perl-modules curl

curl -sSL http://neuro.debian.net/lists/trusty.us-ca.full >> /etc/apt/sources.list.d/neurodebian.sources.list

sed -i -e 's,main *$,main contrib non-free,g' /etc/apt/sources.list.d/neurodebian.sources.list
grep -q 'deb .* multiverse$' /etc/apt/sources.list || sed -i -e 's,universe *$,universe multiverse,g' /etc/apt/sources.list

# Install FSL 5.0.9
apt-get update
apt-get install -y --no-install-recommends curl
curl -sSL http://neuro.debian.net/lists/trusty.us-ca.full >> /etc/apt/sources.list.d/neurodebian.sources.list
apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9
apt-get update
apt-get install -y fsl-core=5.0.9-4~nd14.04+1
apt-get build-dep -y gridengine && apt-get update -y

# Install HCP Pipelines v3.27.0
apt-get update
apt-get install -y --no-install-recommends python-numpy
wget https://github.com/Washington-University/Pipelines/archive/v3.27.0.tar.gz -O pipelines.tar.gz
cd /opt/
mkdir /opt/HCP-Pipelines
tar zxf /opt/pipelines.tar.gz -C /opt/HCP-Pipelines --strip-components=1
rm /opt/pipelines.tar.gz
wget -qO- https://www.doc.ic.ac.uk/~ecr05/MSM_HOCR_v2/MSM_HOCR_v2-download.tgz | tar xz -C /tmp
mv /tmp/homes/ecr05/MSM_HOCR_v2/Ubuntu /opt/HCP-Pipelines/MSMBinaries
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install FIX 1.066, along with dependencies (MCR 2013, R 3.4.4)
apt-get update && apt-get install -y build-essential libpcre3 libpcre3-dev fort77 xorg-dev libbz2-dev liblzma-dev libblas-dev gfortran gcc-multilib gobjc++ libreadline-dev bzip2 libcurl4-gnutls-dev default-jdk gdebi
cd /opt
/opt/gdown.pl/gdown.pl https://drive.google.com/file/d/1GKbQ404vbkDDNUmZzQePBV8CD-ETqOhV/view?usp=sharing /opt/fix.tar.gz
tar zxvf fix.tar.gz
rm fix.tar.gz
mv /opt/fix* /opt/fix
cd /opt
wget https://cloud.r-project.org/bin/linux/ubuntu/trusty/r-base-core_3.4.4-1trusty0_amd64.deb
wget https://cloud.r-project.org/bin/linux/ubuntu/trusty/r-base-dev_3.4.4-1trusty0_all.deb
gdebi -n r-base-core_3.4.4-1trusty0_amd64.deb
gdebi -n r-base-dev_3.4.4-1trusty0_all.deb
apt-get install -y libssl-dev
R --vanilla -e "install.packages('coin', repos='http://cran.us.r-project.org', dependencies=TRUE)" -e "install.packages('strucchange', repos='http://cran.us.r-project.org', dependencies=TRUE)" -e "install.packages('https://cran.r-project.org/src/contrib/Archive/party/party_1.0-25.tar.gz', repos=NULL, type='source')" -e "install.packages('https://cran.r-project.org/src/contrib/Archive/kernlab/kernlab_0.9-24.tar.gz', repos=NULL, type='source')" -e "install.packages('ROCR', repos='http://cran.us.r-project.org', dependencies=TRUE)" -e "install.packages('https://cran.r-project.org/src/contrib/Archive/e1071/e1071_1.6-7.tar.gz', repos=NULL, type='source')" -e "install.packages('https://cran.r-project.org/src/contrib/Archive/randomForest/randomForest_4.6-12.tar.gz', repos=NULL, type='source')"

chmod a+rwx -R /usr/lib/fsl/5.0/ /opt/fix/ /opt/HCP-Pipelines/PostFix/ /opt/HCP-Pipelines/PostFix/Compiled_prepareICAs/ /opt/HCP-Pipelines/RestingStateStats/ /opt/HCP-Pipelines/RestingStateStats/Compiled_RestingStateStats/distrib/ /opt/HCP-Pipelines/MSMAll/scripts/Compiled_ComputeVN/ /opt/HCP-Pipelines/MSMAll/ /opt/HCP-Pipelines/MSMAll/scripts/ /opt/HCP-Pipelines/Examples/Scripts/ /fsl_sub /settings.sh /PostFix.sh /run_prepareICAs.sh /RestingStateStats.sh /run_RestingStateStats.sh /run_RestingStateStats.sh /run_ComputeVN.sh /MSMAllPipeline.sh /MSMAll.sh /generate_level1_fsf.sh /hcp_fix_multi_run /fsl_sub /settings.sh /PostFix.sh /run_prepareICAs.sh /RestingStateStats.sh /run_RestingStateStats.sh /hcp_fix_multi_run /generate_level1_fsf.sh /run_ComputeVN.sh /MSMAllPipeline.sh /MSMAll.sh

cd /opt/HCP-Pipelines/Examples/Scripts/
cp /generate_level1_fsf.sh .
cp /run_ComputeVN.sh /opt/HCP-Pipelines/MSMAll/scripts/Compiled_ComputeVN/run_ComputeVN.sh
cp /MSMAllPipeline.sh /opt/HCP-Pipelines/MSMAll/MSMAllPipeline.sh
cp /MSMAll.sh /opt/HCP-Pipelines/MSMAll/scripts/MSMAll.sh
cp /fsl_sub /usr/lib/fsl/5.0/fsl_sub
cp /settings.sh /opt/fix/settings.sh
cp /PostFix.sh /opt/HCP-Pipelines/PostFix/PostFix.sh
cp /run_prepareICAs.sh /opt/HCP-Pipelines/PostFix/Compiled_prepareICAs/run_prepareICAs.sh
cp /RestingStateStats.sh /opt/HCP-Pipelines/RestingStateStats/RestingStateStats.sh
cp /run_RestingStateStats.sh /opt/HCP-Pipelines/RestingStateStats/Compiled_RestingStateStats/distrib/run_RestingStateStats.sh
cp /hcp_fix_multi_run /opt/fix/hcp_fix_multi_run

mkdir /tmp/v83
cp /opt/fix*/compiled/Linux/x86_64/MCRInstaller.zip /tmp/v83
cd /tmp/v83
unzip MCRInstaller.zip
cd /tmp/v83 && ./install -mode silent -agreetolicense yes -destinationFolder /usr/local/R2014a

# Install Connectome Workbench dev version
apt-get update
cd /opt
wget http://brainvis.wustl.edu/workbench/workbench-rh_linux64-dev_latest.zip
unzip workbench-rh_linux64-dev_latest.zip
export PATH=/opt/workbench/bin_rh_linux64:${PATH}

# Ensure Dependencies for PostFix are met
apt-get update
mkdir /tmp/v81
cd /tmp/v81
wget http://ssd.mathworks.com/supportfiles/MCR_Runtime/R2013a/MCR_R2013a_glnxa64_installer.zip
unzip MCR_R2013a_glnxa64_installer.zip
cd /tmp/v81 && ./install -mode silent -agreetolicense yes -destinationFolder /usr/local/R2013a

# Ensure dependencies for MSMAll are met
apt-get update
mkdir /tmp/v91
cd /tmp/v91
wget http://ssd.mathworks.com/supportfiles/downloads/R2016b/deployment_files/R2016b/installers/glnxa64/MCR_R2016b_glnxa64_installer.zip
unzip MCR_R2016b_glnxa64_installer.zip
cd /tmp/v91 && ./install -mode silent -agreetolicense yes -destinationFolder /usr/local/R2016b

# Install the validator 0.26.11, along with pybids 0.6.0
apt-get update
apt-get install -y curl
curl -sL https://deb.nodesource.com/setup_10.x | bash -
apt-get remove -y curl
apt-get install -y nodejs
npm install -g bids-validator@0.26.11

apt-get update && apt-get install -y --no-install-recommends python-pip python-six python-nibabel python-setuptools python-dev git
pip install git+https://github.com/INCF/pybids.git@0.6.0

# install gradient_unwarp.py (v1.0.3)
pip install https://github.com/Washington-University/gradunwarp/archive/v1.0.3.zip

# upgrade our libstdc++
echo "deb http://ftp.de.debian.org/debian stretch main" >> /etc/apt/sources.list
apt-get update
apt-get install -y --force-yes libstdc++6 nano

# overwrite matlab mcr shared object
rm /usr/local/R2016b/v91/sys/os/glnxa64/libstdc++.so.6
ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/local/R2016b/v91/sys/os/glnxa64/libstdc++.so.6

#chmod 555 -R /

%runscript

exec /run.py "$@"
