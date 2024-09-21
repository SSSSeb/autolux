PACKAGE_NAME=autolux
VERSION=0.0.42
ARCHITECTURE=all
BUILD_DIR=build
DEB_DIR=$(BUILD_DIR)/$(PACKAGE_NAME)-$(VERSION)
SCRIPT_PATH=/usr/local/bin
SYSTEMD_PATH=/lib/systemd/system

all: deb_pkg

deb_pkg: prepare_deb
	dpkg-deb --build $(DEB_DIR) $(BUILD_DIR)

prepare_deb:
	@echo "creating dirs..."
	mkdir -p $(DEB_DIR)/DEBIAN
	mkdir -p $(DEB_DIR)$(SCRIPT_PATH)
	mkdir -p $(DEB_DIR)$(SYSTEMD_PATH)

	@echo "copying files..."
	cp -vf autolux $(DEB_DIR)$(SCRIPT_PATH)/autolux
	cp -vf autolux.service $(DEB_DIR)$(SYSTEMD_PATH)/autolux.service
	cp -vf autolux-deb/DEBIAN/control $(DEB_DIR)/DEBIAN/
	cp -vf autolux-deb/DEBIAN/postinst $(DEB_DIR)/DEBIAN/
	chmod +x $(DEB_DIR)$(SCRIPT_PATH)/autolux

clean:
	@echo "cleaning up..."
	rm -rf $(BUILD_DIR)

