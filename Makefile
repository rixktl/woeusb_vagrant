all: clean build

build:
	vagrant up
	vagrant halt
	VBoxManage clonemedium --format RAW usb.vdi usb.img

clean:
	vagrant destroy -f
	rm -rf usb.vdi
	rm -rf usb.img
