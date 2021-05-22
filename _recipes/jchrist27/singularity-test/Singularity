Bootstrap: docker
From: continuumio/miniconda3

%post
    /opt/conda/bin/conda create -n capstone pandas pytorch tensorflow
	/opt/conda/bin/conda install -n capstone -c huggingface transformers
	
%runscript
    exec /opt/conda/envs/capstone/bin/"$@"