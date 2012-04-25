# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games

DESCRIPTION="a pack of NewGRF-Files from openttdcoop"
HOMEPAGE="http://wiki.openttdcoop.org/GRF"
SRC_URI="http://bundles.openttdcoop.org/grfpack/releases/${PV}/ottdc_grfpack_${PV}.tar.gz
-> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RESTRICT="mirror primaryuri"
DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir -p "${S}" || die
	tar xf "${DISTDIR}/${P}.tar.gz" -C "${S}" || die
	mv "${S}"/ottdc_grfpack/* "${S}" || die
	rmdir "${S}"/ottdc_grfpack || die
}

src_install() {
	cd "${S}"
	insinto "${GAMES_DATADIR}"/openttd/data/
	dodoc readme.txt || die
	rm -f readme.txt || die
	rm -f changelog.txt || die
	rm -f VERSION || die
	doins -r * || die
}
