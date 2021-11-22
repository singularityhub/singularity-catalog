Bootstrap: docker
From: rocker/shiny:4.1.2

%post
    apt update -y && \
    apt install libgdal-dev libproj-dev libgeos-dev libudunits2-dev -y && \
    apt clean -y 
    install2.r shinydashboard \
    shinyWidgets \
    plotly \
    sf \
    googlesheets4 \
    magrittr \
    stringi \
    leaflet \
    leaflet.minicharts \
    reshape2 \
    scales \
    ggsci \
    RColorBrewer \
    DT \
    shinybusy 

%runscript
    /srv/shiny-server/data/Download.Rscript.R
    /usr/bin/shiny-server 2>&1

%startscript
    /srv/shiny-server/data/Download.Rscript.R
    /usr/bin/shiny-server 2>&1

%environment
    export PORT=4051