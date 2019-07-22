FROM ubuntu:latest
MAINTAINER christina.gancayco@gmail.com

WORKDIR /root/
ENV AWS_DEFAULT_REGION us-east-1

ENV GLIBC_VERSION 2.29-r0

# Install Git
RUN apt-get update && apt-get install git && apt-get install python2-dev

# Install Hugo
ADD https://github.com/gohugoio/hugo/releases/download/v0.55.6/hugo_extended_0.55.6_Linux-64bit.tar.gz hugo_extended_0.55.6.tar.gz
RUN tar -xzf hugo_extended_0.55.6.tar.gz
RUN mv hugo /usr/local/bin

# Install AWSCLI
ADD https://s3.amazonaws.com/aws-cli/awscli-bundle.zip awscli-bundle.zip
RUN unzip awscli-bundle.zip
RUN ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

# Copy in script
COPY build-site.sh /root/build-site.sh
RUN chmod +x /root/build-site.sh