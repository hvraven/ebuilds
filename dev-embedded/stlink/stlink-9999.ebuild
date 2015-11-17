# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
#!/bin/bash

EAPI=5

inherit autotools git-r3 linux-info udev

DESCRIPTION="On board debugger driver for stm32-discovery boards."
HOMEPAGE="https://github.com/texane/stlink"
EGIT_REPO_URI="https://github.com/texane/stlink.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="stlinkv1"

DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use stlinkv1 ; then
		linux-info_pkg_setup
		linux_config_exists
		if ! linux_chkconfig_module USB_STORAGE; then
			ewarn "USB_STORAGE must be a module for stlinkv1 support"
		fi
	fi
}

src_prepare() {
	eautoreconf
}

src_install() {
	default
	udev_dorules 49-stlink*.rules
	insinto /etc/modprobe.d
	use stlinkv1 && doins stlink_v1.modprobe.conf
}

pkg_postinst() {
	udev_reload
}
