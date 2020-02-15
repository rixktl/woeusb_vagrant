#!/bin/bash

if [[ $# -lt 1 ]]; then
    echo "$0 <input iso path>"
    exit 1
fi

INPUT_PATH=$1

# Clean up
vagrant destroy -f
rm -rf usb.vdi
rm -rf usb.img

ISO_PATH=$INPUT_PATH vagrant up
if [[ $? -ne 0 ]]; then
    exit 1
fi

vagrant halt
VBoxManage clonemedium --format RAW usb.vdi usb.img

# Clean up
vagrant destroy -f
rm -rf usb.vdi

echo "Installer image is ready: usb.img"
