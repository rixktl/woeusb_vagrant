FROM debian:buster

# Setup for installing debian packages    
ENV DEBIAN_FRONTEND noninteractive    

RUN apt-get update -qq \
    && apt-get install --no-install-recommends -y \
    build-essential \
    devscripts equivs gdebi-core \
    git ca-certificates \
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
    && gdebi --n ../woeusb_*_*.deb

# Post install clean up
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/
COPY . .
ENV IMAGE_SIZE 8G
# CMD ["/bin/bash create_image.sh"]
ENTRYPOINT [ "/bin/bash" ]
