BootStrap: yum
OSVersion: 7
MirrorURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/os/$basearch/
Include: yum

%labels
  AUTHOR nicolas.soirat@etu.umontpellier.fr

%post
  echo "Updating CentOS and installing mandatory packages ..."
  yum -y update
  yum group install -y "development tools"
  yum -y install  wget git zlib-devel which
  #For GATK
  yum -y install java-1.8.0-openjdk-devel
  #For MPA
  yum install -y bzip2-devel ncurses-devel readline-devel tk-devel gdbm-devel xz-devel expat-devel
  mkdir /softwares
  echo "... Done !"
  #For Phenolyzer
  yum -y install perl-devel perl-CPAN perl-GD perl-XML-LibXML perl-Switch perl-DBI
  curl -L http://cpanmin.us | perl - App::cpanminus
  cpanm --force Bio::Perl
  yum -y install perl-devel
  yum -y install perl-CPAN
  curl -L http://cpanmin.us | perl - App::cpanminus
  cpanm --force Bio::Perl
  cpanm Switch
  cpanm Graph::Directed
  cpanm --force Bio::OntologyIO
  cpanm --force Excel::Writer::XLSX

  echo "Installing the lastest release of Python ..."
  yum -y install https://centos7.iuscommunity.org/ius-release.rpm
  yum -y install epel-release
  yum -y install python34
  yum -y install python34-devel
  yum -y install python34-setuptools
  echo "... Done !"
  echo "Installing pip3 ..."
  easy_install-3.4 pip
  pip3 install PyVCF
  echo "... Done !"

  echo "Installing HTSlib & BCFtools ..."
  wget https://github.com/samtools/htslib/releases/download/1.9/htslib-1.9.tar.bz2
  tar -xjf htslib-1.9.tar.bz2
  cd htslib-1.9 && ./configure --prefix=/usr/local && make && make install
  wget https://github.com/samtools/bcftools/releases/download/1.9/bcftools-1.9.tar.bz2
  tar -xjf bcftools-1.9.tar.bz2
  cd bcftools-1.9  && ./configure --prefix=/usr/local && make && make install
  cd / && rm -rf htslib-1.9 htslib-1.9.tar.bz2
  echo "... Done !"

  echo "Installing Cromwell ..."
  # wget https://github.com/broadinstitute/cromwell/releases/download/31.1/cromwell-31.1.jar
  # wget https://github.com/broadinstitute/cromwell/releases/download/36.1/cromwell-36.1.jar
  wget https://github.com/broadinstitute/cromwell/releases/download/60/cromwell-60.jar
  mv cromwell-36.1.jar /softwares
  #echo "Installing BCFtools ..."
  #git clone git://github.com/samtools/htslib.git
  #git clone git://github.com/samtools/bcftools.git
  #cd bcftools
  #make
  #mv bcftools /usr/local/bin
  #cd ..
  #rm -rf bcftools
  #echo "... Done !"

  echo "Installing GATK4 ..."
  wget https://github.com/broadinstitute/gatk/releases/download/4.1.0.0/gatk-4.1.0.0.zip
  unzip gatk-4.1.0.0.zip -d /softwares/
  rm gatk-4.1.0.0.zip
  echo "... Done !"

  #ANNOVAR MUST BE BOUND TO THE CONTAINER
  #e.g. singularity run -B /path/to/annovar/:/media -B /path/to/data/:/mnt achabilarity.simg -c /path/to/conf -i /path/to/json
  #echo "Installing Annovar ..."
  #wget https://neuro-2.iurc.montp.inserm.fr/sources/annovar.tar.gz
  #tar -xzf annovar.tar.gz
  #mv annovar /softwares
  #rm annovar.tar.gz
  #echo "... Done !"

  echo "Installing MPA ..."
  #git clone https://github.com/mobidic/MPA.git
  #mv MPA /softwares
  pip3 install mobidic-mpa
  echo "... Done !"

  echo "Installing Phenolyzer ..."
  git clone https://github.com/WGLab/phenolyzer
  mv phenolyzer /softwares
  echo "... Done !"

  echo "Installing Captain-Achab ..."
  git clone https://github.com/mobidic/Captain-ACHAB.git
  mv Captain-ACHAB /softwares
  echo "... Done !"

  echo "Importing Captain Achab wdl from GitHub ..."
  git clone https://github.com/mobidic/MobiDL
  mv MobiDL /softwares
  sed -i -e "s/modules\//\/softwares\/MobiDL\/modules\//g" /softwares/MobiDL/captainAchab.wdl
  echo ".. Done !"

  echo "Importing Crom-wellWrapped from GitHub ..."
  git clone https://github.com/mobidic/Crom-wellWrapped
  mv Crom-wellWrapped /softwares
  echo "... Done !"

%runscript
  echo "Run Crom-wellWrapped with theses arguments : $*"
  exec /softwares/Crom-wellWrapped/cww.sh -e /softwares/cromwell-36.1.jar -w /softwares/MobiDL/captainAchab.wdl "$@"


#%help
  #Captain ACHAB is a simple and useful interface to analyse NGS data for molecular diagnosis.
  #This container has a wrapper for cromwell you can launch with :

  #Achabilarity.simg -i [yourinputfile]_inputs.json
  #exec /softwares/Crom-wellWrapped/cww.sh -e /softwares/cromwell-36.1.jar -w /softwares/MobiDL/captainAchab.wdl "$@"
  #singularity run -B "/path/to/annovar/:/media" -B "/path/to/data/:/mnt" Achabilarity.simg -o cromwell_options.json -c cromwell.conf -i yourinputsfile_inputs.json

%help
  Captain ACHAB is a simple and useful interface to analysis of WES data for molecular diagnosis.
  This container has a wrapper for cromwell you can launch with :

  /PATH/TO/singularity run  -B "/path/to/annovar/:/media" -B "/path/to/data/:/mnt" Achabilarity.simg -i [yourinputfile]_inputs.json

  More options :
  -c | --conf <file.conf> : To add a cromwell conf file
  -o | --option <option.json> : To add a cromwell option file
  -v | --verbosity <1, 2, 3 or 4> : To set verbosity level (ERROR : 1 | WARNING : 2 | INFO [default] : 3 | DEBUG : 4)
  -h | --help : Print help message in terminal and close the script

  Be careful, you have to put all your input files in the input folder. You need to have 3 files :
  - disease.txt
  - vcf file
  - [yourinputfile]_inputs.json


  #Be careful, you have to put all your input files (except json) in your input folder. You must have these following files :
  #- phenotype.txt
  #- gene_for_pathology.txt
  #- vcf file
  #- Genome of reference
  #- Databases for Annovar
  #- Custom xref
