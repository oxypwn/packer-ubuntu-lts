#!/bin/bash

apt-add-repository ppa:rquillo/ansible
apt-get update && apt-get -y install \
    ansible
