Bootstrap: docker
From: ubuntu:18.04

# Based on https://github.com/icaoberg/docker-meme-suite/blob/master/Dockerfile

%labels
  Maintainer @jacobhepkema
  Version v0.3
  
%post
  # Install prerequisites
  apt-get update && apt-get install -y procps libopenmpi-dev openmpi-bin ghostscript libgs-dev libgd-dev libexpat1-dev zlib1g-dev libxml2-dev autoconf automake libtool libhtml-template-compiled-perl libxml-opml-simplegen-perl libxml-libxml-debugging-perl sudo curl openssh-server
  
  PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install Log::Log4perl'
  PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install Math::CDF'
  PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install CGI'
  PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install HTML::PullParser'
  PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install HTML::Template'
  PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install XML::Simple'
  PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install XML::Parser::Expat'
  PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install XML::LibXML'
  PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install XML::LibXML::Simple'
  PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install XML::Compile'
  PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install XML::Compile::SOAP11'
  PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install XML::Compile::WSDL11'
  PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install XML::Compile::Transport::SOAPHTTP'
  
  mkdir /opt/meme
  # Get meme suite
  curl http://meme-suite.org/meme-software/5.1.0/meme-5.1.0.tar.gz  > /opt/meme/meme-5.1.0.tar.gz 
  cd /opt/meme
  
  tar zxvf meme-5.1.0.tar.gz && rm -fv meme-5.1.0.tar.gz
  cd /opt/meme/meme-5.1.0 && ./configure --prefix=/opt  --enable-build-libxml2 --enable-build-libxslt  --with-url=http://meme-suite.org && make && make install && rm -rfv /opt/meme
  
  export PATH=/opt/bin:$PATH
  
# smoke test
meme -version

%runscript
  exec /bin/bash "$@"
