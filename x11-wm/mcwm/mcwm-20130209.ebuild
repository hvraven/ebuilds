# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Minimalistic floating window manager using XCB"
HOMEPAGE="http://hack.org/mc/projects/mcwm/"
SRC_URI="http://hack.org/mc/projects/${PN}/${P}-2.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/libxcb
	x11-libs/xcb-util
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-wm"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-2"

src_install() {
	dobin mcwm hidden
	newman mcwm.man mcwm.1
	newman hidden.man hidden.1
}
