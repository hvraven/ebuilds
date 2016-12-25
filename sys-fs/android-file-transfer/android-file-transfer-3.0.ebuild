# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
#!/bin/bash

EAPI=6

inherit cmake-utils

DESCRIPTION="MTP client with minimalistic UI"
HOMEPAGE="https://github.com/whoozle/android-file-transfer-linux"
SRC_URI="https://github.com/whoozle/android-file-transfer-linux/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fuse libusb +qt5"

DEPEND="sys-apps/file
	fuse? ( sys-fs/fuse )
	libusb? ( virtual/libusb:1 )
	qt5? ( dev-qt/qtwidgets:5 )"
RDEPEND="${DEPEND}"

src_unpack() {
	default
	mv ${PN}-linux-${PV} ${P} || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_FUSE=$(usex fuse)
		-DUSB_BACKEND_LIBUSB=$(usex libusb)
		-DBUILD_QT_UI=$(usex qt5)
		-DDESIRED_QT_VERSION=5
	)
	cmake-utils_src_configure
}
