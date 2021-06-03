Bootstrap: docker
From: bids/freesurfer:latest

%environment

FSLDIR=/usr/share/fsl/5.0
FSLOUTPUTTYPE=NIFTI_GZ
PATH=/usr/lib/fsl/5.0:$PATH
FSLMULTIFILEQUIT=TRUE
POSSUMDIR=/usr/share/fsl/5.0
LD_LIBRARY_PATH=/usr/lib/fsl/5.0:$LD_LIBRARY_PATH
FSLTCLSH=/usr/bin/tclsh
FSLWISH=/usr/bin/wish
FSLOUTPUTTYPE=NIFTI_GZ

OS=Linux
FS_OVERRIDE=0
FS_LICENSE=/opt/freesurfer/subjects/license.txt
FSF_OUTPUT_FORMAT=nii.gz
MNI_DIR=/opt/freesurfer/mni
LOCAL_DIR=/opt/freesurfer/local
FREESURFER_HOME=/opt/freesurfer
FSFAST_HOME=/opt/freesurfer/fsfast
MINC_BIN_DIR=/opt/freesurfer/mni/bin
MINC_LIB_DIR=/opt/freesurfer/mni/lib
MNI_DATAPATH=/opt/freesurfer/mni/data
FMRI_ANALYSIS_DIR=/opt/freesurfer/fsfast
PERL5LIB=/opt/freesurfer/mni/lib/perl5/5.8.5
MNI_PERL5LIB=/opt/freesurfer/mni/lib/perl5/5.8.5
PATH=/opt/freesurfer/bin:/opt/freesurfer/fsfast/bin:/opt/freesurfer/tktools:/opt/freesurfer/mni/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export FSLDIR FSLOUTPUTTYPE PATH FSLMULTIFILEQUIT POSSUMDIR LD_LIBRARY_PATH FSLTCLSH FSLWISH FSLOUTPUTTYPE OS FS_OVERRIDE FS_LICENSE FSF_OUTPUT_FORMAT MNI_DIR LOCAL_DIR FREESURFER_HOME FSFAST_HOME MINC_BIN_DIR MINC_LIB_DIR MNI_DATAPATH FMRI_ANALYSIS_DIR PERL5LIB MNI_PERL5LIB

%runscript

/run.py
