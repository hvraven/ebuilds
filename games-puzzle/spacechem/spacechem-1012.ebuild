# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games

DESCRIPTION="puzzle game with atoms and molecules"
HOMEPAGE="http://spacechemthegame.com"
SRC_URI="SpaceChem-${PV}-hib.tar.gz"

LICENSE="commercial"
SLOT="0"
KEYWORDS="~x86 ~amd64 -*"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/mono"

RESTRICT="fetch"

pkg_nofetch() {
	elog "Please download"
	elog "    ${SRC_URI}"
	elog "from ${HOMEPAGE} and place it in ${DISTDIR}"
}

src_unpack() {
	unpack "${A}" || die
	ar x *.deb || die
	unpack ./data.tar.gz || die
}

src_install() {
	mv opt "${ED}${GAMES_PREFIX_OPT}" || die
	dosym "${GAMES_PREFIX_OPT}/zachtronicsindustries/${PN}/spacechem-launcher.sh" "${GAMES_BINDIR}/${PN}" || die
	dodoc README || die

	prepgamesdirs
}
