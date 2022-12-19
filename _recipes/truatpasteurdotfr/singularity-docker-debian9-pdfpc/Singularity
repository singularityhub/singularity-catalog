BootStrap: library
From: debian:9

%post
export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get -y upgrade
apt-get -y install pdfpc  # that should be enough, imho 

# if you want to fix the error: QGtkStyle could not resolve GTK. Make sure you have installed the proper libraries.
# uncomment the following line
#apt-get -y install libgnomeui-0

# if you want to fix the error: Gtk-Message: Failed to load module "pk-gtk-module"
# uncomment the following line:
#apt-get -y  install packagekit-gtk3-module

# if you want to fix the error: Gtk-Message: Failed to load module "canberra-gtk-module"
# uncomment the following line:
#apt-get -y install libcanberra-gtk0

# all in one line "full" much bigger version
# uncomment the following line
# apt-get -y install libgnomeui-0 packagekit-gtk3-module libcanberra-gtk0

# specific to my setup
mkdir -p /local-storage /mnt/beegfs /baycells/home /baycells/scratch /c6/shared /c6/eb /local/gensoft2 /c6/shared/rpm /Bis/Scratch2 /mnt/beegfs

touch /singularity-`date +%Y%m%d-%H%M%S`

%runscript
echo "running pdfpc from the container"
pdfpc "$@"

