# The plinkr R package, with the multiple PLINK versions installed

# Works, see https://github.com/richelbilderbeek/tidyverse_singularity
Bootstrap: docker
From: rocker/tidyverse

%post
    # From https://github.com/brucemoran/Singularity/blob/8eb44591284ffb29056d234c47bf8b1473637805/shub/bases/recipe.CentOs7-R_3.5.2#L21
    echo 'export LANG=en_US.UTF-8 LANGUAGE=C LC_ALL=C LC_CTYPE=C LC_COLLATE=C  LC_TIME=C LC_MONETARY=C LC_PAPER=C LC_MEASUREMENT=C' >> $SINGULARITY_ENVIRONMENT

    Rscript -e 'install.packages(c("remotes", "devtools"))'
    Rscript -e 'remotes::install_github("richelbilderbeek/plinkr")'
    Rscript -e 'plinkr::install_plinks(plink_optionses = plinkr::create_plink_optionses(plink_folder = "/opt/plinkr"))'

%runscript
echo "'plinkr.sif' running with arguments '$@'"
Rscript "$@"

%test
    Rscript -e 'plinkr::plinkr_report(plink_optionses = plinkr::create_plink_optionses(plink_folder = "/opt/plinkr"))'

%help

This container has the R package plinkr and multiple versions of PLINK installed.

To make the container run a script called, e.g. `script.R`, do:

```
singularity run plinkr.sif script.R
```

Within the script, set `plink_folder` to `/opt/plinkr`, for example:

```
library(plinkr)

# The options for the multiple versions of PLINK
plink_optionses <- create_plink_optionses(plink_folder = "/opt/plinkr")

# Use PLINK v1.9, i.e. plink_optionses[[2]]
assoc(
  assoc_data = create_demo_assoc_data(),
  assoc_params = create_test_assoc_params(),
  plink_options = plink_optionses[[2]]
)
```

%labels

    AUTHOR Richel J.C. Bilderbeek

    NAME plinkr

    DESCRIPTION The plinkr R package, with the multiple PLINK versions installed

    USAGE simply run the container

    URL https://github.com/richelbilderbeek/plinkr

    VERSION 0.20.2
