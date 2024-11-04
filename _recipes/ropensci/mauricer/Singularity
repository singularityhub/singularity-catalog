# The mauricer R package, with BEAST2 installed

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
    Rscript -e 'remotes::install_github("richelbilderbeek/mauricerinstall")'
    Rscript -e 'beastierinstall::install_beast2_pkg(folder_name = "/opt/beastier")'

%runscript
exec R --vanilla --silent --no-echo "$@"

%test
    Rscript -e 'beastier::beastier_report(beast2_folder = "/opt/beastier")'

%help

This container has the R package mauricer, the tool BEAST2 and the BEAST2
package 'NS' installed.

When using this container, set `beast2_folder` to `/opt/beastier`.
To obtain the  `beast2_path` use `beastier::get_default_beast2_path`.

For example:

```
library(mauricer)

# Folder that contains BEAST2
beast2_folder <- "/opt/beastier"

# The BEAST2 NS package is installed
is_beast2_ns_pkg_installed(beast2_folder = beast2_folder)
is_beast2_pkg_installed(name = "NS", beast2_folder = beast2_folder)

# The BEAST2 bacter package is not installed
is_beast2_pkg_installed(name = "bacter", beast2_folder = beast2_folder)
```

%labels

    AUTHOR Richel J.C. Bilderbeek

    NAME mauricer
 
    DESCRIPTION The mauricer R package, with BEAST2 and the BEAST2 NS package installed

    USAGE send the script to the container

    URL https://github.com/ropensci/mauricer

    VERSION 2.5.5
