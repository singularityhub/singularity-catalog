Bootstrap: docker
From: alpine:edge

%labels
    AUTHOR icaoberg
    EMAIL icaoberg@psc.edu
    WEBSITE http://www.andrew.cmu.edu/~icaoberg

%post
    apk update
    apk add imagemagick

####################################################################################
#  ___                            __  __             _      _
# |_ _|_ __ ___   __ _  __ _  ___|  \/  | __ _  __ _(_) ___| | __
#  | || '_ ` _ \ / _` |/ _` |/ _ \ |\/| |/ _` |/ _` | |/ __| |/ /
#  | || | | | | | (_| | (_| |  __/ |  | | (_| | (_| | | (__|   <
# |___|_| |_| |_|\__,_|\__, |\___|_|  |_|\__,_|\__, |_|\___|_|\_\
#                      |___/                   |___/
####################################################################################
%apphelp magick
    magick --help

%apprun magick
    magick "$@"

%apphelp animate
    animate --help

%apprun animate
    animate "$@"

%apphelp compare
    compare --help

%apprun compare
    compare "$@"

%apphelp composite
    composite --help

%apprun composite
    composite "$@"

%apphelp conjure
    conjure --help

%apprun conjure
    conjure "$@"

%apphelp convert
    convert --help

%apprun convert
    convert "$@"

%apphelp display
    display --help

%apprun display
    display "$@"

%apphelp identify
    identify --help

%apprun identify
    identify "$@"

%apphelp mogrify
    mogrify --help

%apprun mogrify
    mogrify "$@"

%apphelp montage
    montage --help

%apprun montage
    montage "$@"
####################################################################################
