# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/opengfx/opengfx-0.4.4.ebuild,v 1.7 2012/04/19 11:53:28 ago Exp $

EAPI=3
inherit games mercurial

EHG_REPO_URI="http://hg.openttdcoop.org/opengfx"

DESCRIPTION="OpenGFX data files for OpenTTD"
HOMEPAGE="http://bundles.openttdcoop.org/opengfx/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=">=games-util/nml-0.2.3"
RDEPEND=""

S=${WORKDIR}/${P}-source

src_prepare() {
	sed -i -e 's/\[a-z\]/[[:alpha:]]/' ./scripts/Makefile.in || die

	# ensure that we will not use gimp to regenerate the pngs
	# causes sandbox violations and not worth the effort anyway
	sed -i \
		-e 's:echo "gimp":echo "":g' \
		scripts/Makefile.def || die
}

src_compile() {
	emake bundle || die
}

src_install() {
	insinto "${GAMES_DATADIR}/openttd/data/"
	doins *.grf opengfx.obg || die
	dodoc docs/{changelog.txt,readme.txt}
	prepgamesdirs
}
