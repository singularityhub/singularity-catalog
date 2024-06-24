BootStrap: docker
From: taavipall/repeatmasker-image

%labels
  Maintainer tpall
  RM_Version 4.0.9
  RMBlast Version 2.9.0
  TRF Version 4.09
  Repbase_Version 20181026

%apprun RepeatMasker
  exec /usr/local/bin/RepeatMasker "${@}"

%runscript
  exec /usr/local/bin/RepeatMasker "${@}"
