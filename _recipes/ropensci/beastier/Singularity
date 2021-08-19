# The beastier R package, with BEAST2 installed

Bootstrap: docker
From: r-base

%post
    sed -i 's/$/ universe/' /etc/apt/sources.list
    apt-get update
    apt-get -y install libssl-dev libcurl4-openssl-dev libxml2-dev r-cran-stringi libicu-dev r-cran-rjava
    apt-get clean
    Rscript -e 'install.packages(c("remotes", "devtools"))'
    Rscript -e 'remotes::install_github("ropensci/beastier")'
    Rscript -e 'remotes::install_github("richelbilderbeek/beastierinstall")'
    Rscript -e 'beastierinstall::install_beast2(folder_name = "/opt/beastier")'

%runscript
exec R --vanilla --silent --no-echo "$@"

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

    VERSION 2.4.6
