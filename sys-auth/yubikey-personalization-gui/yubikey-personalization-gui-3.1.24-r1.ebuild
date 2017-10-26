# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic qmake-utils

DESCRIPTION="GUI for personalization of Yubico's YubiKey"
SRC_URI="http://yubico.github.io/yubikey-personalization-gui/releases/${P}.tar.gz"
HOMEPAGE="https://github.com/Yubico/yubikey-personalization-gui"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="BSD-2"
IUSE="debug test"

RDEPEND="
	>=sys-auth/ykpers-1.14.0
	>=sys-auth/libyubikey-1.6
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-libs/glib:2
	virtual/libusb:1"
DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:5 )
	virtual/pkgconfig"

DOCS=( NEWS README )

src_prepare() {
	if ! use test ; then
		sed -i YKPersonalization.pro \
			-e 's/src \\/src/' \
			-e '/tests/d' || die
	fi

	default
}

src_configure() {
	append-cxxflags -std=c++11

	eqmake5 "CONFIG+=nosilent" YKPersonalization.pro
}

src_install() {
	dobin build/release/yubikey-personalization-gui
	doman resources/lin/yubikey-personalization-gui.1
	domenu resources/lin/yubikey-personalization-gui.desktop
	doicon resources/lin/yubikey-personalization-gui.xpm
	doicon -s 128 resources/lin/yubikey-personalization-gui.png
}
