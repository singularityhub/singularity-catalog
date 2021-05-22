Like docker. Virtual containers to easily manage dependencies.

Official Website: https://singularity.lbl.gov/

User Guide: https://sylabs.io/guides/3.3/user-guide/index.html

**Note:** ROSIE runs Singularity version 3.3

Singularity is a platform that enables organized installation and management of custom libraries and code. Singularity creates virtual machiines that can be dispatched across nodes on the cluster, creating homogeneous virtual working environments. 

Singularity’s command line interface allows you to interact with containers transparently. You can run programs inside a container as if they were running on your host system. You can easily redirect IO, use pipes, pass arguments, and access files, sockets, and ports on the host system from within a container.

Singularity containers are saved as .sif files. A sif file can be instantiated to a running virtual machine. The user can enter this virtual machine, create a shell session, and execute command line arguments.

### Executing commands in Singularity Image

You can execute a command in a container. This will execute the command, then quit the container. This is useful for creating a job, as the sif can hold all required job files.

```bash
$ singularity exec -B /data:/data /data/containers/ubuntu_20.04.sif cat /etc/os-release
```
**Note:** Add cluster datapool to Container with -B bind flag.

You can also add NVIDIA GPU to container command execution with --nv flag

```bash
$ singularity exec --nv /data/containers/msoe-tensorflow.sif cat /etc/os-release
```

### Interactive Singularity Shell

You can enter an interactive shell with a singularity image. The `-b` flag will bind mount data into the container, with the pattern `host:conatiner`. The `-nv` flag will mount the gpus into the virtual machine.

```bash
# cpu ubuntu workbox
$ singularity shell -B /data:/data /data/containers/ubuntu_20.04.sif
```

You can attach gpus to the interactive shell. 

```bash
# --nv flags attached node gpus and tensorflow
$ srun --pty --gres=gpu:t4:1 singularity shell --nv -B /data:/data /data/containers/msoe-tensorflow.sif
```

If you combine the above command with SLURM, you can schedule a active shell session on a T4 compute node!

### ROSIE Available Singularity Images

The cluster has the following singularity containers available for use:

| Image Name          | Container Location in Cluster        |
|---------------------|--------------------------------------|
| ubuntu_18.04.sif    | /data/containers/ubuntu_18.04.sif    |
| ubuntu_20.04.sif    | /data/containers/ubuntu_20.04.sif    |
| msoe-tensorflow.sif | /data/containers/msoe-tensorflow.sif |

### Building Singularity Images

Users can create their own singulairyt images from the popular docker images on the DockerHub or NVIDIA GPU Cloud. To create a singularity image from a docker container:

```bash
$ singularity build Singularity.ubuntu.sif docker://ubuntu:latest
```

This will create a singularity image `Singularity.ubuntu.sif` of the latest tag docker ubuntu container.

See singularity [folder](/singularity) for example singularity definition files.

To request a custom singularity image for batch execution, query your research mentor or faculty advisor with:

  * Clear reason for needing custom container workspace.
  * Singularity def file created and tested on local machine.
  * Copy of Singularity file in cluster home directory.

#### Definition File

The definition file allows you to create singularity images with custom libraries and code. In the below example, I install a python image processing library onto a base docker tensorflow container. This enables me to schedule image data cleaning jobs on the batch nodes.

```
Bootstrap: docker
From: tensorflow:19.07-py3
Registry: nvcr.io
Namespace: nvidia
# -----------------------------------------------------------------------------------

%post
# -----------------------------------------------------------------------------------
# this will install all necessary packages and prepare the container

    apt-get update && apt-get -y upgrade
    apt-get -y install \
        libvips-dev \
        libvips-tools \
        python3 \
        python3-pip
    python3 -m pip install --upgrade pip
    python3 -m pip install --upgrade setuptools
    python3 -m pip install pyvips
```