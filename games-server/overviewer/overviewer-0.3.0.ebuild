# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

PYTHON_DEPEND="2:2.7"
PYTHON_RESTRICT_ABIS="3.*"
inherit games distutils

DESCRIPTION="A map generator for a minecraft"
HOMEPAGE="http://overviewer.org"
SRC_URI="https://github.com/overviewer/Minecraft-Overviewer/tarball/v${PV} ->
${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~i686 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
dev-python/numpy
dev-python/imaging"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	unpack ${A}
	mv ${PN}-* ${P} || die
}

src_prepare() {
	sed -e "s/share\/doc\/minecraft-overviewer/share\/doc\/${P}/" \
		-e "s/'COPYING.txt', //" \
		-i setup.py || die
}

src_install() {
	distutils_src_install
	insinto /usr/share/${P}
	doins ${FILESDIR}/terrain.png
}
