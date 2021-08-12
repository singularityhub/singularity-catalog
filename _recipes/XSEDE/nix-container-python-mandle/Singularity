Bootstrap: docker-daemon
From: jec/mandle:latest
# BE SURE TO REPLACE THE ABOVE WITH YOUR USERNAME AND IMAGE NAME

%labels 
  base_image "nix-python-mandle:v0.0.1"
  version "1.0.0"
  software "Mandle"
  software.version "1.0.0"
  about.summary "A simple Mandlebrot zoom-in gif generator"
  about.home "https://github.com/XSEDE/nix-container-python-mandle"
  about.documentation "https://github.com/XSEDE/nix-container-python-mandle"
  about.license_file "https://github.com/XSEDE/nix-container-python-mandle"
  about.license "MIT"
  about.tags "example-container" 
  extra.binaries "/apps/zoom_mandle.py"
  authors "XCRI <help@xsede.org>"

%post
 chmod a+x /apps/zoom_mandle.py

%runscript
#Simply pass any commandline arguments to our python script
/apps/zoom_mandle.py $@

%help
 This container will run a python script that creates a b&w straight-line zoom-in gif
of the Mandlebrot Set, with adjustable speed, time, beginning window size, 
origin, and end-size.
