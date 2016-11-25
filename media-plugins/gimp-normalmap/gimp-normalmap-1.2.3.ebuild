# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DESCRIPTION="Gimp plug-in for converting images into RGB normal maps"
HOMEPAGE="https://code.google.com/p/gimp-normalmap/"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/gimp-normalmap/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-gfx/gimp-2.6
	media-libs/glew:0
	x11-libs/gtk+:2
	x11-libs/gtkglext"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${P}-makefile.patch" )

src_install() {
	exeinto "$(pkg-config --variable=gimplibdir gimp-2.0)/plug-ins"
	doexe normalmap
	dodoc README
}
