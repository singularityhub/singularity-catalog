Bootstrap: localimage
From: /master/home/tru/singularity.d/containers/c7-conda-pytorch-10.1-2020-02-04-1920.sif
### or build from scratch by adapting the c7-conda-pytorch-10.1/Singularity

%post
PATH=/opt/miniconda3/bin:$PATH
export PATH

# shapegan via pip
python3 -m pip install \
	 mesh-to-sdf \
	 trimesh \
	 pyopengl \
	 pyrender \
	 sklearn \
	 scikit-image \
	 pygame \
	 opencv-python  \

# missing X11?
yum -y update
yum -y install libX11 libXext libglvnd-glx libSM libXrender libX11-devel nano git zip unzip mesa-libGLU-devel glib2
 
%environment
PATH=/opt/miniconda3/bin:$PATH
export PATH

