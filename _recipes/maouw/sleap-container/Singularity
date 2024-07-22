Bootstrap: docker
From: mambaorg/micromamba:{{ MICROMAMBA_TAG }}

%arguments
	MICROMAMBA_TAG=jammy-cuda-12.3.1
	SLEAP_VERSION=1.3.3

%environment
	export MAMBA_DOCKERFILE_ACTIVATE=1

%post
	export CI=1
	micromamba install --verbose -y -n base -c conda-forge -c nvidia -c sleap -c anaconda sleap={{ SLEAP_VERSION }}
    micromamba clean -y --all --force-pkgs-dirs

