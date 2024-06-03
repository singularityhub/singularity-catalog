Bootstrap: docker
From: neurodebian:stretch
Stage: spython-base

# Based on FLYWHEEL's (https://github.com/flywheel-apps/bxh-xcede-tools-qa) Docker container
%files
run ${FLYWHEEL}/run
stat_metadata.py ${FLYWHEEL}/stat_metadata.py
manifest.json ${FLYWHEEL}/manifest.json
%labels
MAINTAINER Zachary Pick
%post
# Creates Singularity container that runs bxh-xcede-tools fmriqa algorithms
#
#

# Start with neurodebian image

# Add non-free sources
echo deb http://neurodeb.pirsquared.org data main contrib non-free >> /etc/apt/sources.list.d/neurodebian.sources.list
echo deb http://neurodeb.pirsquared.org stretch full contrib non-free >> /etc/apt/sources.list.d/neurodebian.sources.list

# Install packages
apt update
DEBIAN_FRONTEND='noninteractive' apt-get install -y \
lsb-core \
libarchive-tools
apt-get install -y \
zip \
unzip
apt-get install -y \
gzip \
curl
apt-get install -y \
jq \
python3-pip \
afni

# Download/install bhx-xcede tools
VERSION=bxh_xcede_tools-1.11.14-lsb30.x86_64
LINK=https://www.nitrc.org/frs/download.php/10144/${VERSION}.tgz
curl -#L  $LINK | bsdtar -xf- -C /opt/
PATH=$PATH:/opt/${VERSION}/bin

# Download/Install webpage2html
COMMIT=4dec20eba862335aaf1718d04b313bdc96e7dc8e
URL=https://github.com/zTrix/webpage2html/archive/$COMMIT.zip
curl -#L  $URL | bsdtar -xf- -C /opt/
cd /opt
mv webpage2html-$COMMIT webpage2html
pip3 install -r webpage2html/requirements.txt
pip3 install beautifulsoup4

mkdir "/usr/share/fonts/default" && ln -s /usr/share/fonts/type1/gsfonts /usr/share/fonts/default/Type1

# Make directory for flywheel spec (v0)
FLYWHEEL=/localdata/scheduler/pipelines/sources/bxh-xcede-tools-qa
bash -c cd /localdata/scheduler/pipelines/sources/bxh-xcede-tools-qa

# Copy executable/manifest to Gear

# Configure entrypoint
%environment
export VERSION=bxh_xcede_tools-1.11.14-lsb30.x86_64
export LINK=https://www.nitrc.org/frs/download.php/10144/${VERSION}.tgz
export PATH=$PATH:/opt/${VERSION}/bin
export COMMIT=4dec20eba862335aaf1718d04b313bdc96e7dc8e
export URL=https://github.com/zTrix/webpage2html/archive/$COMMIT.zip
export FLYWHEEL=/flywheel/v0
%runscript
bash -c cd /localdata/scheduler/pipelines/sources/bxh-xcede-tools-qa
bash -c exec ./run "$@"
%startscript
bash -c cd /localdata/scheduler/pipelines/sources/bxh-xcede-tools-qa
bash -c exec ./run "$@"
