bootstrap: docker
from: nextgenusfs/funannotate

%files

.gm_key /home/linuxbrew/.gm_key     # GENEMARK Key
RepBaseRepeatMaskerEdition-20170127.tar.gz /home/linuxbrew/   # Register at repbase(The most recent version fails to build)
psx.c /home/linuxbrew/PASApipeline/pasa-plugins/seqclean/psx/ # psx creates a hardlink which fails on our machines, use modified psx.c so that we are copying files instead

%post

. /home/linuxbrew/conda/bin/activate
cd /home/linuxbrew

tar xvf RepBaseRepeatMaskerEdition-20170127.tar.gz -C /home/linuxbrew/repeatmasker

rm -rf RepBaseRepeatMaskerEdition-20170127.tar.gz 

cd repeatmasker

perl ./configure < /home/linuxbrew/repeatmasker.txt

cd ../repeatmodeler

cpan App::cpanminus
cpanm JSON
cpanm URI
cpanm LWP::UserAgent


perl ./configure < /home/linuxbrew/repeatmodeler.txt

/home/linuxbrew/funannotate/funannotate setup -d /home/linuxbrew/DB


chmod 755 -R /home/linuxbrew


cd /home/linuxbrew/PASApipeline

make all


echo "export QUARRY_PATH=/home/linuxbrew/CodingQuarry_v2.0/QuarryFiles" >> $SINGULARITY_ENVIRONMENT
