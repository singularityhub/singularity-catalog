# The babette R package, with BEAST2 and the BEAST2 NS package installed
Bootstrap: docker
From: rocker/tidyverse

%post
    # From https://github.com/brucemoran/Singularity/blob/8eb44591284ffb29056d234c47bf8b1473637805/shub/bases/recipe.CentOs7-R_3.5.2#L21
    echo 'export LANG=en_US.UTF-8 LANGUAGE=C LC_ALL=C LC_CTYPE=C LC_COLLATE=C  LC_TIME=C LC_MONETARY=C LC_PAPER=C LC_MEASUREMENT=C' >> $SINGULARITY_ENVIRONMENT

    sudo apt-get install -qq libcurl4-openssl-dev

    apt search openjdk
    sudo apt install -qq openjdk-11-jre-headless
    # sudo apt install -qq default-jre
    # sudo apt-get install -qq r-cran-rjava
    # sudo apt-get install -qq openjdk-13-*
    sudo $(which R) CMD javareconf

    sudo apt install -qq libfontconfig1-dev

    sudo apt install -qq libharfbuzz-dev libfribidi-dev

    Rscript -e 'install.packages(c("remotes", "rcmdcheck"))'
    Rscript -e 'remotes::install_cran("shiny")'
    Rscript -e 'install.packages("devtools")'
    Rscript -e 'remotes::install_github("ropensci/beastier")'
    Rscript -e 'remotes::install_github("richelbilderbeek/beastierinstall")'
    Rscript -e 'beastierinstall::install_beast2(folder_name = "/opt/beastier")'

%runscript
echo "'beastier.sif' running with arguments '$@'"
exec "$@"

%test
    Rscript -e 'beastier::beastier_report(beast2_folder = "/opt/beastier")'

%help

This container has the R package beastier and the tool BEAST2 installed.

When using this container, set `beast2_folder` to `/opt/beastier`.
To obtain the  `beast2_path` use `beastier::get_default_beast2_path`.

For example:

```
library(beastier)

# Folder that contains BEAST2
beast2_folder <- "/opt/beastier"

# Path to the BEAST2 binary/jar file
beast2_path <- get_default_beast2_path(
  beast2_folder = beast2_folder
)

# Setup a default BEAST2 run, using the BEAST2 XML file 2_4.xml
beast2_options <- create_beast2_options(
  input_filename = get_beastier_path("2_4.xml"),
  beast2_path = beast2_path
)

# Run BEAST2
run_beast2_from_options(beast2_options)
```

%labels

    AUTHOR Richel J.C. Bilderbeek

    NAME beastier
 
    DESCRIPTION The beastier R package, with BEAST2 installed

    USAGE send an R script as text to the container via a pipe

    URL https://github.com/ropensci/beastier

    VERSION 2.4.12
