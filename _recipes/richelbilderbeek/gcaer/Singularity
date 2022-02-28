Bootstrap: library
From: richelbilderbeek/default/ormr:0.6.2.2

%post
    Rscript -e 'remotes::install_github("richelbilderbeek/plinkr")'
    Rscript -e 'remotes::install_github("richelbilderbeek/gcaer")'
    # Use gcae.sif, which has GCAE installed
    # Rscript -e 'gcaer::install_gcae(gcae_options = gcaer::create_gcae_options(gcae_folder = "/opt/GenoCAE", ormr_folder_name = "python3"), verbose = TRUE)'
    # Rscript -e 'gcaer::gcaer_report(gcae_options = gcaer::create_gcae_options(gcae_folder = "/opt/GenoCAE", ormr_folder_name = "python3"))'

%runscript
echo "'gcaer.sif' running with arguments '$@'"
Rscript "$@"

%test
    Rscript -e 'plinkr::plinkr_report(plink_optionses = plinkr::create_plink_optionses(plink_folder = "/opt/plinkr"))'
    Rscript -e 'ormr::ormr_report(ormr_folder_name = "python3", verbose = TRUE)'

    # Use gcae.sif, which has GCAE installed
    # Rscript -e 'gcaer::is_gcae_installed(gcae_options = gcaer::create_gcae_options(gcae_folder = "/opt/GenoCAE", ormr_folder_name = "python3"), verbose = TRUE)'

%help

This container has the R package gcaer and GCAE installed, 
including the needed Python packages.

To make the container run a script called, e.g. `script.R`, do:

```
singularity run gcaer.sif script.R
```

NOT: The GCAE scripts can be found at '/opt/GenoCAE', 
which is the same as the `gcae_folder` parameter.

NOT: The installed Python packages can be found at '/opt/ormr_gcaer', 
which is the same as the `ormr_folder_name` parameter.

NOT: Due to this, within your scripts, 
set `gcae_options` to `create_gcae_options(gcae_folder = "/opt/GenoCAE", ormr_folder_name = "/opt/ormr_gcaer")`, 
for example:

```
# library(gcaer)
# gcae_options <- create_gcae_options(gcae_folder = "/opt/GenoCAE", ormr_folder_name = "/opt/ormr_gcaer")
# run_gcae(args = "--help", gcae_options = gcae_options)
```

%labels

    AUTHOR Richel J.C. Bilderbeek

    NAME gcaer

    DESCRIPTION The gcaer R package, with PLINK and Python packages installed

    USAGE Run with an R script, i.e. `singularity run gcaer.sif script.R`

    URL https://github.com/richelbilderbeek/gcaer

    VERSION 0.6.3
