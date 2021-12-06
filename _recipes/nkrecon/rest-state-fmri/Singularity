Bootstrap: docker
From: neurodebian:xenial

%help
exec /opt/bin/startup.sh "-h"


%setup
cp ./src/resting_pipeline.py $SINGULARITY_ROOTFS
cp ./src/fsl_sub $SINGULARITY_ROOTFS
cp ./src/statusfeat.py $SINGULARITY_ROOTFS
cp ./src/runfeat-1.py $SINGULARITY_ROOTFS
cp ./src/make_fsl_stc.py $SINGULARITY_ROOTFS
cp ./src/startup.sh $SINGULARITY_ROOTFS
cp ./src/readme $SINGULARITY_ROOTFS
cp ./src/version $SINGULARITY_ROOTFS

%environment
export FSLDIR=/usr/share/fsl/5.0
export BXHVER=bxh_xcede_tools-1.11.1-lsb30.x86_64
export BXHBIN=/opt/$BXHVER
export RSFMRI=/opt/rsfmri_python
export PATH=$PATH:$BXHBIN/bin
export PATH=$PATH:$BXHBIN/lib
export PATH=$PATH:$RSFMRI/bin
export PATH=$PATH:$FSLDIR/bin
export PATH=$PATH:/opt/bin
export LD_LIBRARY_PATH=/.singularity.d/libs:$LD_LIBRARY_PATH

%files

%runscript
cd /opt/data
exec /opt/bin/startup.sh "$@"

%test

%post
mkdir -p /uaopt /extra /xdisk /rsgrps /opt/data /opt/bin /opt/work /opt/input /opt/output
export BXHVER=bxh_xcede_tools-1.11.1-lsb30.x86_64
export BXHLOC=7384
export BXHBIN=/opt/$BXHVER
export RSFMRI=/opt/rsfmri_python
export FSLDIR=/usr/share/fsl/5.0
# install FSL
# Making fsl-complete available as it is no longer contribution-free
# Reference: http://lists.alioth.debian.org/pipermail/neurodebian-users/2016-April/001052.html 
echo 'fsl-complete is not contribution-free. making it available for install'
sed -i -e 's,main$,main contrib non-free,g' /etc/apt/sources.list.d/neurodebian.sources.list
apt-get update && apt-get install -y \
	fsl-complete \
	wget \
	lsb-core \
	python-pip 
pip install numpy
pip install scipy
pip install nibabel
pip install networkx==1.11
cd /tmp

cd /tmp
wget "http://www.nitrc.org/frs/download.php/$BXHLOC/$BXHVER.tgz"
wget "https://wiki.biac.duke.edu/_media/biac:analysis:rsfmri_python.tgz"
tar -xzf $BXHVER.tgz -C /opt
mv biac:analysis:rsfmri_python.tgz rsfmri_python.tgz
tar -xzf rsfmri_python.tgz  -C /opt
rm rsfmri_python.tgz
rm $BXHVER.tgz

chmod -R 777 /opt 

mv /resting_pipeline.py /opt/rsfmri_python/bin
mv /fsl_sub $FSLDIR/bin
mv /statusfeat.py /opt/bin
mv /runfeat-1.py /opt/bin
mv /make_fsl_stc.py /opt/bin
mv /startup.sh /opt/bin
mv /readme /opt/bin
mv /version /opt/bin

cd /opt/data

echo ". $FSLDIR/etc/fslconf/fsl.sh" >> $SINGULARITY_ENVIRONMENT


