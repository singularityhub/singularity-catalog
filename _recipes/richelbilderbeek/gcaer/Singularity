Bootstrap: library
From: richelbilderbeek/default/ormr:0.6.2

%post
    Rscript -e 'remotes::install_github("richelbilderbeek/plinkr")'
    Rscript -e 'remotes::install_github("richelbilderbeek/gcaer")'
    Rscript -e 'gcaer::install_gcae(gcae_options = gcaer::create_gcae_options(gcae_folder = "/opt/GenoCAE", ormr_folder_name = "/opt/ormr_gcaer"), verbose = TRUE)'
    Rscript -e 'gcaer::gcaer_report(gcae_options = gcaer::create_gcae_options(gcae_folder = "/opt/GenoCAE", ormr_folder_name = "/opt/ormr_gcaer"))'

%runscript
exec R --vanilla --silent --no-echo "$@"

%test
    Rscript -e 'gcaer::is_gcae_installed(gcae_options = gcaer::create_gcae_options(gcae_folder = "/opt/GenoCAE", ormr_folder_name = "/opt/ormr_gcaer"), verbose = TRUE)'

%help

This container has the R package gcaer and GCAE installed, 
including the needed Python packages.

To make the container run a script called, e.g. `script.R`, do:

```
cat script.R | ./gcaer.sif
```

The GCAE scripts can be found at '/opt/GenoCAE', 
which is the same as the `gcae_folder` parameter.

The installed Python packages can be found at '/opt/ormr_gcaer', 
which is the same as the `ormr_folder_name` parameter.

Due to this, within your scripts, 
set `gcae_options` to `create_gcae_options(gcae_folder = "/opt/GenoCAE", ormr_folder_name = "/opt/ormr_gcaer")`, 
for example:

```
library(gcaer)
gcae_options <- create_gcae_options(gcae_folder = "/opt/GenoCAE", ormr_folder_name = "/opt/ormr_gcaer")
run_gcae(args = "--help", gcae_options = gcae_options)
```



%labels

    AUTHOR Richel J.C. Bilderbeek

    NAME gcaer

    DESCRIPTION The gcaer R package, with PLINK and Python packages installed

    USAGE send an R script to the container, e.g. `cat script.R | ./gcaer.sif`

    URL https://github.com/richelbilderbeek/gcaer

    VERSION 0.6.1
