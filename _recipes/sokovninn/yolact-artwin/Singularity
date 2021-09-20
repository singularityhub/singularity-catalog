Bootstrap: docker

From: continuumio/miniconda3

%files
    environment.yml

%environment
    export PATH="/opt/conda/envs/yolact-env/bin:$PATH"

%post
    apt-get -y update
    apt-get install -y gcc libc-dev ffmpeg libsm6 libxext6
    #. /opt/conda/etc/profile.d/conda.sh
    #echo ". /opt/conda/etc/profile.d/conda.sh" >> $SINGULARITY_ENVIRONMENT
    #echo "conda activate yolact-env" >> $SINGULARITY_ENVIRONMENT
    /opt/conda/bin/conda env create -f environment.yml
    #conda activate yolact-env
    git clone https://github.com/sokovninn/yolact-artwin.git

%runscript
    exec bash -c "source activate /opt/conda/envs/yolact-env/ && python /yolact-artwin/$@"

# Examples:
# sudo singularity build yolact.sif Singularity
# sudo singularity exec --nv yolact.sif bash
# sudo singularity exec --nv yolact.sif bash -c "source activate /opt/conda/envs/yolact-env/
&& python /yolact-artwin/eval.py"
# sudo singularity run --nv --bind /local/datagen/yolact-artwin/data/weights/:/weights yolact
.sif "eval.py --score_threshold=0.15 --trained_model=/weights/yolact_base_54_800000.pth --image=/yolact-artwin/my_image.png:/weights/re
sult.png"
