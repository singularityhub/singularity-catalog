BootStrap: docker
From: ruby:3.2

%labels
    Maintainer Bioinformation and DDBJ Center
    Version    v1.0

%files
    . /opt/metabobank_tools

%environment
    export PUBLIC_FILE_PATH=/lustre9/open/shared_data/metabobank/study

%post
    cd /opt/metabobank_tools
    bundle install
    bundle exec rake install
    bundle exec rake clobber
