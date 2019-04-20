# https://hackernoon.com/can-you-run-chefdk-and-kitchen-docker-inside-of-a-docker-container-10c384571f34
# Explains how this Dockerfile was composed as it is - excellent read!
from ubuntu:18.04

RUN apt-get update && \
    apt-get install -y curl docker.io vim locales build-essential

# Matches my user on the host, 501 appears to be the ID the first user on a
# Mac gets
RUN useradd -u 501 gdha && \
    mkdir -p /home/gdha && \
    chown gdha:gdha /home/gdha

# Needed to make nerdtree plugin for vim work
RUN locale-gen en_US.UTF-8 && \
    echo "export LC_CTYPE=en_US.UTF-8" >> /home/gdha/.bashrc && \
    echo "export LC_ALL=en_US.UTF-8" >> /home/gdha/.bashrc

# Install gems in a folder locally rather than globally
RUN echo "alias bundle-install='/opt/chefdk/embedded/bin/bundle install --path vendor --binstubs'" >> /home/gdha/.bashrc

RUN curl -O https://packages.chef.io/files/stable/chefdk/3.6.57/ubuntu/18.04/chefdk_3.6.57-1_amd64.deb && \
    dpkg -i chefdk_3.6.57-1_amd64.deb

# Use the ruby, bundle, gem etc that comes with chef rather than having to
# install them all seperatly
ENV PATH="/opt/chefdk/embedded/bin:${PATH}"
# Need to be able to talk to the Docker socket
RUN usermod -a -G staff gdha

RUN mkdir -m 0777 /nodes

USER gdha
