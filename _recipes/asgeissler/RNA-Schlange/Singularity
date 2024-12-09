Bootstrap: docker
From: condaforge/mambaforge:latest
Stage: spython-base

%files
envs/r.yaml /conda-envs/81349e987b92efdd9c42d5622123e303/environment.yaml
envs/sortmerna.yaml /conda-envs/b3a58c9dd8d8c7ef4943a32053eca134/environment.yaml
%labels
io.github.snakemake.containerized="true"
io.github.snakemake.conda_env_hash="6361a69b2f86b2a5d26ea0bfeea7b71b4228009ab7e104c5587d090032e5dd4a"
%post

# Step 1: Retrieve conda environments

# Conda environment:
#   source: https://github.com/snakemake/snakemake-wrappers/raw/v1.10.0/bio/sra-tools/fasterq-dump/environment.yaml
#   prefix: /conda-envs/85633ff8bea713d372cb9152f291c3a8
#   channels:
#     - conda-forge
#     - bioconda
#     - nodefaults
#   dependencies:
#     - sra-tools >2.9.1
#     - pigz >=2.6
#     - pbzip2 >=1.1
#     - snakemake-wrapper-utils =0.3
mkdir -p /conda-envs/85633ff8bea713d372cb9152f291c3a8
wget https://github.com/snakemake/snakemake-wrappers/raw/v1.10.0/bio/sra-tools/fasterq-dump/environment.yaml -O /conda-envs/85633ff8bea713d372cb9152f291c3a8/environment.yaml

# Conda environment:
#   source: envs/r.yaml
#   prefix: /conda-envs/81349e987b92efdd9c42d5622123e303
#   channels:
#       - conda-forge
#       - bioconda
#       - defaults
#   dependencies:
#       - r-base
#       - r-cowplot
#       - r-essentials >= 4.0
#       - r-ggrepel
#       - r-ggsci
#       - r-magick
#       - r-pheatmap
#       - r-rcolorbrewer
#       - r-tidyverse
#       - bioconductor-biostrings
#       - bioconductor-bsgenome
#       - bioconductor-deseq2
#       - bioconductor-plyranges
#       - bioconductor-rtracklayer
mkdir -p /conda-envs/81349e987b92efdd9c42d5622123e303

# Conda environment:
#   source: envs/sortmerna.yaml
#   prefix: /conda-envs/b3a58c9dd8d8c7ef4943a32053eca134
#   channels:
#       - bioconda
#       - defaults
#   dependencies:
#       - sortmerna =4.3.4
mkdir -p /conda-envs/b3a58c9dd8d8c7ef4943a32053eca134

# Conda environment:
#   source: https://github.com/snakemake/snakemake-wrappers/raw/v1.10.0/bio/fastp/environment.yaml
#   prefix: /conda-envs/ead20a3f8bbfa36fbb2e0c3f905c1787
#   channels:
#     - conda-forge
#     - bioconda
#     - nodefaults
#   dependencies:
#     - fastp =0.20
mkdir -p /conda-envs/ead20a3f8bbfa36fbb2e0c3f905c1787
wget https://github.com/snakemake/snakemake-wrappers/raw/v1.10.0/bio/fastp/environment.yaml -O /conda-envs/ead20a3f8bbfa36fbb2e0c3f905c1787/environment.yaml

# Conda environment:
#   source: https://github.com/snakemake/snakemake-wrappers/raw/v1.12.0/bio/fastqc/environment.yaml
#   prefix: /conda-envs/573927d1a2f1de4bfdd03a5385f50ed8
#   channels:
#     - conda-forge
#     - bioconda
#     - nodefaults
#   dependencies:
#     - fastqc ==0.11.9
mkdir -p /conda-envs/573927d1a2f1de4bfdd03a5385f50ed8
wget https://github.com/snakemake/snakemake-wrappers/raw/v1.12.0/bio/fastqc/environment.yaml -O /conda-envs/573927d1a2f1de4bfdd03a5385f50ed8/environment.yaml

# Conda environment:
#   source: https://github.com/snakemake/snakemake-wrappers/raw/v3.2.0/bio/multiqc/environment.yaml
#   prefix: /conda-envs/a74c0ac65c84ed438731c3397703af31
#   channels:
#     - conda-forge
#     - bioconda
#     - nodefaults
#   dependencies:
#     - multiqc =1.18
mkdir -p /conda-envs/a74c0ac65c84ed438731c3397703af31
wget https://github.com/snakemake/snakemake-wrappers/raw/v3.2.0/bio/multiqc/environment.yaml -O /conda-envs/a74c0ac65c84ed438731c3397703af31/environment.yaml

# Conda environment:
#   source: https://github.com/snakemake/snakemake-wrappers/raw/v3.2.0/bio/salmon/index/environment.yaml
#   prefix: /conda-envs/58a327d476856b9082ebbfd2ce43537c
#   channels:
#     - conda-forge
#     - bioconda
#     - nodefaults
#   dependencies:
#     - salmon =1.10.2
mkdir -p /conda-envs/58a327d476856b9082ebbfd2ce43537c
wget https://github.com/snakemake/snakemake-wrappers/raw/v3.2.0/bio/salmon/index/environment.yaml -O /conda-envs/58a327d476856b9082ebbfd2ce43537c/environment.yaml

# Conda environment:
#   source: https://github.com/snakemake/snakemake-wrappers/raw/v3.2.0/bio/salmon/quant/environment.yaml
#   prefix: /conda-envs/c9b8e6e6cf962163ad419bc658b71b79
#   channels:
#     - bioconda
#     - conda-forge
#     - nodefaults
#   dependencies:
#     - salmon =1.10.2
#     - gzip =1.13
#     - bzip2 =1.0.8
mkdir -p /conda-envs/c9b8e6e6cf962163ad419bc658b71b79
wget https://github.com/snakemake/snakemake-wrappers/raw/v3.2.0/bio/salmon/quant/environment.yaml -O /conda-envs/c9b8e6e6cf962163ad419bc658b71b79/environment.yaml

# Step 2: Generate conda environments

mamba env create --prefix /conda-envs/81349e987b92efdd9c42d5622123e303 --file /conda-envs/81349e987b92efdd9c42d5622123e303/environment.yaml && \
mamba env create --prefix /conda-envs/b3a58c9dd8d8c7ef4943a32053eca134 --file /conda-envs/b3a58c9dd8d8c7ef4943a32053eca134/environment.yaml && \
mamba env create --prefix /conda-envs/ead20a3f8bbfa36fbb2e0c3f905c1787 --file /conda-envs/ead20a3f8bbfa36fbb2e0c3f905c1787/environment.yaml && \
mamba env create --prefix /conda-envs/573927d1a2f1de4bfdd03a5385f50ed8 --file /conda-envs/573927d1a2f1de4bfdd03a5385f50ed8/environment.yaml && \
mamba env create --prefix /conda-envs/a74c0ac65c84ed438731c3397703af31 --file /conda-envs/a74c0ac65c84ed438731c3397703af31/environment.yaml && \
mamba env create --prefix /conda-envs/58a327d476856b9082ebbfd2ce43537c --file /conda-envs/58a327d476856b9082ebbfd2ce43537c/environment.yaml && \
mamba env create --prefix /conda-envs/c9b8e6e6cf962163ad419bc658b71b79 --file /conda-envs/c9b8e6e6cf962163ad419bc658b71b79/environment.yaml && \
mamba env create --prefix /conda-envs/85633ff8bea713d372cb9152f291c3a8 --file /conda-envs/85633ff8bea713d372cb9152f291c3a8/environment.yaml && \
mamba clean --all -y

%runscript
exec /bin/bash "$@"
%startscript
exec /bin/bash "$@"
