# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games

DESCRIPTION="a pack of NewGRF-Files from openttdcoop"
HOMEPAGE="http://wiki.openttdcoop.org/GRF"
SRC_URI="http://bundles.openttdcoop.org/grfpack/releases/${PV}/ottdc_grfpack_${PV}.tar.gz
-> ${P}.tar.gz"

LICENSE="GPL-3 CC-BY-NC-3.0 CC-BY-NC-SA-3.0 CC-BY-NC-ND-3.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RESTRICT="mirror primaryuri"
DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/ottdc_grfpack"

src_install() {
	dodoc readme.txt
	rm -f readme.txt changelog.txt VERSION || die

	insinto "${GAMES_DATADIR}"/openttd/data/
	doins -r *
}
