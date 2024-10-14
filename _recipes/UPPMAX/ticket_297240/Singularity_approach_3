Bootstrap: docker
From: continuumio/anaconda3

%post
    # From https://github.com/brucemoran/Singularity/blob/8eb44591284ffb29056d234c47bf8b1473637805/shub/bases/recipe.CentOs7-R_3.5.2#L21
    echo 'export LANG=en_US.UTF-8 LANGUAGE=C LC_ALL=C LC_CTYPE=C LC_COLLATE=C  LC_TIME=C LC_MONETARY=C LC_PAPER=C LC_MEASUREMENT=C' >> $SINGULARITY_ENVIRONMENT

    # conda install --channel "conda-forge" pyopenssl=17.0.0.*
    # conda install --channel "timl" pyopenssl=17.0.0
    conda install --channel "free" pyopenssl=17.0.0

    conda install --channel "bioconda" bcftools
    conda install --channel "HCC" cellranger


%runscript
python "$@"