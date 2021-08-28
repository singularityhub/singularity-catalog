Bootstrap: docker
From: debian:buster-slim

# close copy of https://github.com/m-wierzba/cat-container
# with some updates for cat12.8

%files
  ./code/main /usr/local/bin/main

%post
  apt-get update
  apt-get -y install wget unzip libxext6 libxt6 moreutils

  TMPDIR="$(mktemp -d)"

  # download MCR and CAT12 (version specified here)
  MCRZIP="MCR_R2017b_glnxa64_installer.zip"
  CAT12ZIP="CAT12.8_r1871_R2017b_MCR_Linux.zip"
  CAT12DIR=$(basename -s .zip ${CAT12ZIP})

  wget -P "${TMPDIR}" "https://ssd.mathworks.com/supportfiles/downloads/R2017b/deployment_files/R2017b/installers/glnxa64/${MCRZIP}" \
    && unzip -q -d "${TMPDIR}/MCR" "${TMPDIR}/${MCRZIP}"
  wget -P "${TMPDIR}" "http://www.neuro.uni-jena.de/cat12/${CAT12ZIP}" \
    && unzip -q -d /opt/ "${TMPDIR}/${CAT12ZIP}"

  # install MCR (to default location)
  "${TMPDIR}"/MCR/install -mode silent -agreeToLicense yes

  # install SPM/CAT12 (from CAT12 download)
  # this command follows a "first execution" https://en.wikibooks.org/wiki/SPM/Standalone#Usage
  "/opt/${CAT12DIR}/run_spm12.sh" /usr/local/MATLAB/MATLAB_Runtime/v93 quit
  chmod +rx "/opt/${CAT12DIR}"/*spm12*

  # install CAT standalone interface
  STANDALONE="/opt/${CAT12DIR}/standalone"
  chmod +rx "${STANDALONE}"/*.sh
  cp -s "${STANDALONE}"/*.sh /usr/local/bin

  # set permissions
  find /opt -type f -print0 | xargs -0 chmod +r
  find /opt/CAT12.8_r1871_R2017b_MCR_Linux/spm12_mcr -type f -print0 | xargs -0 chmod +rx
  chmod 777 /usr/local/bin/main
 
  rm -fr "${TMPDIR}"

  apt-get clean
  apt-get autoremove

%environment
  export MCRROOT=/usr/local/MATLAB/MATLAB_Runtime/v93
  export MCR_INHIBIT_CTF_LOCK=1
  export SPMROOT=/opt/CAT12.8_r1871_R2017b_MCR_Linux
  export STANDALONE="${SPMROOT}/standalone"

%runscript
  exec /usr/local/bin/main "$@"
