FROM debian:buster

# Setup for installing debian packages    
ENV DEBIAN_FRONTEND noninteractive    

RUN apt-get update -qq \
    && apt-get install --no-install-recommends -y \
    build-essential \
    libwxgtk3.0-dev dosfstools devscripts equivs gdebi-core \
    git ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && update-ca-certificates

WORKDIR /usr/src/woeusb
RUN git clone https://github.com/slacka/WoeUSB WoeUSB

WORKDIR /usr/src/woeusb/WoeUSB
# Hack the get pass setup failure
RUN ./setup-development-environment.bash || true \
    && ./setup-development-environment.bash

RUN mk-build-deps \
    && gdebi --n woeusb-build-deps_*_all.deb

RUN dpkg-buildpackage -uc -b \
    && apt-get update -qq \
    && gdebi --n ../woeusb_*_*.deb

ENTRYPOINT ["/bin/bash"]
