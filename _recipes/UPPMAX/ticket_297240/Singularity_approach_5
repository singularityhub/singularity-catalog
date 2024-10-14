Bootstrap: docker
From: chainguard/bazel:latest

%post
    # From https://github.com/brucemoran/Singularity/blob/8eb44591284ffb29056d234c47bf8b1473637805/shub/bases/recipe.CentOs7-R_3.5.2#L21
    echo 'export LANG=en_US.UTF-8 LANGUAGE=C LC_ALL=C LC_CTYPE=C LC_COLLATE=C  LC_TIME=C LC_MONETARY=C LC_PAPER=C LC_MEASUREMENT=C' >> $SINGULARITY_ENVIRONMENT

    cd /opt
    git clone https://github.com/10XGenomics/cellranger
    cd cellranger

    # Tip from https://stackoverflow.com/q/61869719
    touch WORKSPACE

    # Tip from https://raw.githubusercontent.com/10XGenomics/cellranger/main/conda_spec.bzl
    echo 'load(":conda_spec.bzl", "anaconda_workspace")' > WORKSPACE
    echo 'anaconda_workspace()' >> WORKSPACE

    # Tip from error message
    touch BUILD

    bazel build conda_spec.bzl

%runscript
python "$@"