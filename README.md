# WoeUSB vagrant
Use vagrant & ansible & WoeUSB to create windows installer usb. <br/>
Works on MacOS & latest Win10 installer image.

# Dependencies
```
vagrant
ansible
virtualbox
```

# Usage
```
ISO_PATH=~/Downloads/Win10_x64.iso make
# result in usb.img, use etcher to burn image to usb (8 GB minimum)
make clean # Remove all generated files and registry in virtualbox, do it after usb is ready
```
