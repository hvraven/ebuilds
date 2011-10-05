# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games

MY_PN=SpaceChem

DESCRIPTION="A puzzle game where you have to work with chemistry"
HOMEPAGE="http://spacechemthegame.com"
SRC_URI="${MY_PN}-${PV}-hib.tar.gz"
RESTRICT="fetch"


LICENSE="commercial"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

pkg_nofetch() {
	einfo "Please download"
	einfo "    ${MY_PN}-${PV}-hib.tar.gz"
	einfo "from ${HOMEPAGE} and place it in ${DISTDIR}"
}

src_unpack() {
	mkdir -p "${S}" || die
	tar xvf "${DISTDIR}/${MY_PN}-${PV}-hib.tar.gz" -C "${S}" || die
	cd "${S}" || die
	ar x "${MY_PN}-i386.deb" || die
	tar xf data.tar.gz || die
}

src_install() {
	insinto /
	doins -r opt
	doins -r usr
	dosym "zachtronicsindustries-spacechem" /usr/bin/spacechem
}
