# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
#!/bin/bash

EAPI=5

inherit eutils flag-o-matic wxwidgets

MY_P="pwsafe-${PV}BETA"
DESCRIPTION="Password manager with wxGTK based frontend"
HOMEPAGE="http://pwsafe.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.tgz"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="yubikey"

COMMON_DEPEND="dev-libs/xerces-c
	sys-apps/util-linux
	sys-devel/gettext
	x11-libs/libXt
	x11-libs/libXtst
	x11-libs/wxGTK:3.0[X]
	yubikey? (
		sys-auth/libyubikey
		sys-auth/ykpers
		)"
DEPEND="${COMMON_DEPEND}
	>=sys-devel/make-3.81"
RDEPEND="${COMMON_DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_pretend() {
	einfo "Checking for -std=c++11 support in compiler"
	test-flags-CXX -std=c++11 > /dev/null || die
}

src_prepare() {
	# remove hard coded compilers and compiler flags
	sed -e '/^export CXXFLAGS/d' -i Makefile.linux || die
	sed -i src/core/Makefile src/os/linux/Makefile src/ui/wxWidgets/Makefile \
		-e 's/-O[0-3]\?//g' -e 's/-g(gdb)\?//g' \
		-e '/^CC=/d' -e '/^CXX=/d' || die

	# generator for the version.h only adds \r breaking the c file
	cp src/ui/wxWidgets/version.in src/ui/wxWidgets/version.h || die

	# binary name pwsafe is in use by app-misc/pwsafe, we use passwordsafe
	# instead. Perform required changes in linking files
	sed -i install/desktop/pwsafe.desktop -e "s/pwsafe/${PN}/g" || die
	sed -i docs/pwsafe.1 \
		-e 's/PWSAFE/PASSWORDSAFE/' \
		-e "s/^.B pwsafe/.B ${PN}/" || die
}

src_configure() {
	if ! use yubikey ; then
		export NO_YUBI=1
	fi

	WX_GTK_VER=3.0 need-wxwidgets unicode

	append-cxxflags -std=c++11
}

src_compile() {
	emake unicoderelease
	emake help
	emake I18N
}

src_install() {
	newbin src/ui/wxWidgets/GCCUnicodeRelease/pwsafe ${PN}
	newman docs/pwsafe.1 ${PN}.1

	dodoc README.txt docs/{ReleaseNotes.txt,ChangeLog.txt}

	insinto /usr/share/pwsafe/xml
	doins xml/*

	insinto /usr/share/locale
	doins -r src/ui/wxWidgets/I18N/mos/*

	# The upstream Makefile builds this .zip file from html source material for
	# use by the package's internal help system. Must prevent
	# Portage from applying additional compression.
	docompress -x /usr/share/doc/${PN}/help
	insinto /usr/share/doc/${PN}/help
	doins help/*.zip

	newicon install/graphics/pwsafe.png ${PN}.png
	newmenu install/desktop/pwsafe.desktop ${PN}.desktop
}
