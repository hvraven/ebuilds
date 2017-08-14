# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Eeschema schematics renderer and viewer"
HOMEPAGE="https://neo900.org/stuff/eeshow/"
EGIT_REPO_URI="https://neo900.org/git/eeshow.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/libgit2
	media-gfx/imagemagick
	media-gfx/transfig
	x11-libs/cairo
	x11-libs/gtk+:3"
RDEPEND="${DEPEND}"

src_prepare() {
	# respect CFLAGS
	sed -e 's/^CFLAGS = -g/CFLAGS +=/' -i Makefile || die

	default
}

src_compile() {
	emake V=1
}

src_install() {
	PREFIX="${D}/usr" emake install
}
