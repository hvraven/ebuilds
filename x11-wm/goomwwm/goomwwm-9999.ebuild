# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 toolchain-funcs

DESCRIPTION="Get out of my way, Window Manager!"
HOMEPAGE="https://github.com/seanpringle/goomwwm"
EGIT_REPO_URI="https://github.com/seanpringle/goomwwm.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/freetype
	x11-libs/libX11
	x11-libs/libXft"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	tc-export CC
	export LDADD=$(pkg-config --cflags --libs x11 xinerama xft)
	sed -e 's:\($(LDADD)\) \(-o goomwwm\):\1 $(LDFLAGS) \2:' \
		-i Makefile || die
}

src_install() {
	doman goomwwm.1
	dodoc README.md
	dobin goomwwm
}