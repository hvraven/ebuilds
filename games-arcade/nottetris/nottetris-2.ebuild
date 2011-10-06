# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games eutils

DESCRIPTION="A game with all the upsides of Tetris and all the downsides of
physics."
HOMEPAGE="http://stabyourself.net/nottetris2/"
SRC_URI="${PN}${PV}-source.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=">=games-engines/love-0.7"

RESTRICT="fetch"

S="${WORKDIR}/Not Tetris"

pkg_nofetch() {
	elog "Please download"
	elog "    ${SRC_URI}"
	elog "from ${HOMEPAGE} and place it in ${DISTDIR}"
}

src_install() {
	dodoc *.txt || die
	insinto "${GAMES_DATADIR}/${PN}/"
	doins *.love || die
	make_wrapper ${PN} "love Not\ Tetris\ 2.love" "${GAMES_DATADIR}/${PN}/"
}