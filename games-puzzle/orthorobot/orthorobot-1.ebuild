# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games eutils

DESCRIPTION="A perspective based puzzle game, where you flatten the view to move
across gaps"
HOMEPAGE="http://stabyourself.net/orthorobot/"
SRC_URI="${PN}-source.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=">=games-engines/love-0.7"

RESTRICT="fetch"

S="${WORKDIR}/Ortho Robot"

pkg_nofetch() {
	elog "Please download"
	elog "    ${SRC_URI}"
	elog "from ${HOMEPAGE} and place it in ${DISTDIR}"
}

src_install() {
	insinto "${GAMES_DATADIR}/${PN}/"
	doins *.love || die
	make_wrapper ${PN} "love Ortho\ Robot.love" "${GAMES_DATADIR}/${PN}/"
}
