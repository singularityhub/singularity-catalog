Bootstrap: docker
From: glotzerlab/software:flux

%labels
	MAINTAINER csadorf

%post
	ln -s /usr/bin/python3 /usr/bin/python
	pip install -U \
		Click==7.0 \
		freud-analysis==0.11.4 \
		h5py==2.9.0 \
		Keras==2.2.4 \
		numpy==1.15.4 \
		pandas==0.23.4 \
		pythia-learn==0.2.4 \
		rmsd==1.3.0 \
		rowan==1.1.0 \
		scikit-learn==0.20.2 \
		scipy==1.2.0 \
		tensorflow==1.12.0 \
		umap-learn==0.3.6

%environment
	export LC_ALL=C
