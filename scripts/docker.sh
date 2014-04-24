#!/bin/bash


# add vagrant to group docker
sudo usermod -a -G docker vagrant

# Update your sources
apt-get update

# Install. Confirm install.
apt-get install -y docker.io
