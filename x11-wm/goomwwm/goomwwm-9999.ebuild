# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2

DESCRIPTION="Get out of my way, Window Manager!"
HOMEPAGE="https://github.com/seanpringle/goomwwm"
EGIT_REPO_URI="https://github.com/seanpringle/goomwwm.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="media-libs/freetype
x11-libs/libX11
x11-libs/libXft"
RDEPEND="${DEPEND}"

src_install() {
	doman goomwwm.1 || die
	dodoc README.md || die
	dobin goomwwm || die
}
