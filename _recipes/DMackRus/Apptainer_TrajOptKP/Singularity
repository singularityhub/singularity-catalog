bootstrap:docker
From:ubuntu:20.04

%labels

AUTHOR Rafael Papallas (rpapallas.com)

%environment
    export LANG=C.UTF-8
    export LC_ALL=C.UTF-8
    export XDG_RUNTIME_DIR=/tmp  # This fixes an issue with /run read-only permissions when using Rviz and other tools.
    export ROS_ROOT=/opt/ros/noetic/share/ros
    export ROS_PACKAGE_PATH=/opt/ros/noetic/share:/opt/ros/noetic/stacks
    export ROS_MASTER_URI=http://localhost:11311
    export LD_LIBRARY_PATH=/opt/ros/noetic/lib:/.singularity.d/libs
    export CPATH=/opt/ros/noetic/include
    export PATH=/opt/ros/noetic/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    export PKG_CONFIG_PATH=/opt/ros/noetic/lib/pkgconfig
    export CMAKE_PREFIX_PATH=/opt/ros/noetic
    export ROS_ETC_DIR=/opt/ros/noetic/etc/ros
%files
  scripts /scripts

%post
  /scripts/post_script.sh

%runscript
  exec /bin/bash "$@" --rcfile /scripts/run_script.sh
