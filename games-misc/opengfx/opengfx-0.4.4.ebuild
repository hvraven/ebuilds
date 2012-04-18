# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/opengfx/opengfx-0.3.6.ebuild,v 1.2 2011/10/10 05:45:07 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="OpenGFX data files for OpenTTD"
HOMEPAGE="http://bundles.openttdcoop.org/opengfx/"
SRC_URI="http://bundles.openttdcoop.org/opengfx/releases/${PV}/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE=""

S=${WORKDIR}/${P}-source

DEPEND=">=games-util/nml-0.2
>=media-gfx/gimp-2.4"
RDEPEND=""

src_compile() {
	# gimp uses the home dir as tmp dir
	GIMP2_DIRECTORY="${WORKDIR}" \
		GEGL_PATH="${WORKDIR}" GEGL_SWAP="${WORKDIR}" \
		emake bundle || die
}

src_install() {
	insinto "${GAMES_DATADIR}/openttd/data/"
	doins *.grf opengfx.obg || die
	dodoc docs/{changelog.txt,readme.txt}
	prepgamesdirs
}
