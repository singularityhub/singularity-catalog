Bootstrap: oras
From: ghcr.io/truatpasteurdotfr/singularity-docker-stream8-ci:latest

%post
dnf -y update && dnf -y upgrade

# https://brave.com/linux/
dnf -y install dnf-plugins-core && \
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/ &&\
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc && \
dnf -y install \
	libglvnd-glx \
	mesa-dri-drivers \
	yum-utils \
	brave-browser && \
dnf clean packages


%runscript
# --no-sandbox is a security risk
# brave lives mostly in /opt/brave.com
# if that is mounted read-write in an overlay or bind mounted we can update on the fly
mkdir /opt/brave.com/can_i_write 2>> /dev/null && \
echo trying to upgrade &&\
D=`mktemp -d` && \
cd $D && \
reposync --download-path $D \
--config /etc/yum.repos.d/brave-browser-rpm-release.s3.brave.com_x86_64_.repo \
--repo brave-browser-rpm-release.s3.brave.com_x86_64_ \
--newest-only \
&& \
rpm2cpio brave-browser-rpm-release.s3.brave.com_x86_64_/brave-browser*.rpm | (cd / && cpio -iumdV 2>>/dev/null) \
; \
cd / && rm -rf /opt/brave.com/can_i_write $D && \
echo done
 
# otherwise just use the provided version
# ignoring the other files in /usr/ and /etc
brave-browser --no-sandbox "$@"

