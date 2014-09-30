#!/bin/bash -ex

cd $WORKSPACE

export PROJECT_NAME=packer-ubuntu-lts

# Pre cleanup
vboxmanage controlvm $PROJECT_NAME poweroff || true
vboxmanage unregistervm $PROJECT_NAME --delete || true
rm -rf $WORKSPACE/output-ubuntu-lts || true
rm -rf "/var/lib/jenkins/VirtualBox\ VMs/$PROJECT_NAME" || exit 1;

id

$(which packer) build ./$PROJECT_NAME-virtualbox.json || exit 1;

S3_BUCKET=
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=



$(which gof3r) put -c 1 -p $WORKSPACE/$PROJECT_NAME.box -b $S3_BUCKET -k vagrant/$PROJECT_NAME.box || exit 1;
mv $WORKSPACE/$PROJECT_NAME.box /data/www/vagrant/boxes

# Post cleanup
rm $WORKSPACE/$PROJECT_NAME.box || true

