all: clean build

build:
	vagrant up
	vagrant halt
	VBoxManage clonemedium --format RAW usb.vdi usb.img

clean:
	vagrant destroy -f
	rm -rf usb.vdi
	rm -rf usb.img
	VBoxManage closemedium disk usb.img &>/dev/null || true
	VBoxManage closemedium disk usb.vdi &>/dev/null || true
	@echo === *Warning: iso image will be unregistered from virtualbox.* ===
	VBoxManage closemedium dvd $$ISO_PATH &>/dev/null || true
