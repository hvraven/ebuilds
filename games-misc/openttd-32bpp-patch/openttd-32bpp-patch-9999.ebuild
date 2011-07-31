# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games mercurial

DESCRIPTION="32bpp graphics patch for OpenTTD"
HOMEPAGE="http://wiki.openttd.org/32bit_Graphics_Development"
SRC_URI=""

EHG_REPO_URI="http://mz.openttdcoop.org/hg/32bpp-extra"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	mercurial_src_unpack || die
}

src_install() {
	insinto "${GAMES_DATADIR}"/openttd/data/
	tar cf 32bpp_extra.tar 32bpp_extra.grf sprites || die
	doins 32bpp_extra.tar || die
	prepgamesdirs
}

pkg_postinst() {
	elog "This patch requires manual activation inside the game."
	elog "You can activate it under \"NewGRF Settings\" in the main menu."
}
