FROM ubuntu:20.04

RUN apt update && apt install -y sudo wget

# installing the dependencies
RUN apt update -qq
RUN apt install -y software-properties-common dirmngr gnupg
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# Adding CRAN repository to system sources list
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
# Installing R-base
RUN apt install -y apt-transport-https
RUN apt install -y r-base locales locales-all
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Install R-base packages
RUN R -e "install.packages(c('shiny', 'rmarkdown'))"

ADD https://github.com/openanalytics/shinyproxy-demo/blob/master/Rprofile.site  /usr/lib/R/etc/

RUN R -e "install.packages('shinyproxy', repos='https://github.com/openanalytics/shinyproxy-demo/blob/master/shinyproxy_0.0.1.tar.gz', type='source')"

RUN R -e "shinyproxy::run_01_hello()"