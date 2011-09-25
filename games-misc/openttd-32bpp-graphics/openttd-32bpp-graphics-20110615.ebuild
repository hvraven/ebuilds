# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games

MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"
DESCRIPTION="32bpp graphic files for OpenTTD"
HOMEPAGE="http://wiki.openttd.org/32bit_Graphics_Development"
SRC_URI="!dev? (
http://bundles.openttdcoop.org/32bpp/nightly-megapacks/32bit-gfx-nightly-megapack-${MY_PV}.tar
-> ${P}.tar
http://coblitz.codeen.org/jupix.info/openttd/gfxdev-nightlies/files/32bit-gfx-nightly-megapack-${MY_PV}.tar
-> ${P}.tar
http://jupix.info/openttd/gfxdev-nightlies/files/32bit-gfx-nightly-megapack-${MY_PV}.tar
-> ${P}.tar )
dev? (
http://jupix.info/openttd/gfxdev-nightlies/files/32bit-gfx-nightly-megapack-${MY_PV}-dev.tar
-> ${P}-dev.tar )
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dev"

DEPEND="app-arch/tar"
RDEPEND="${DEPEND}"

src_unpack() {
	if use dev ; then
		cp "${DISTDIR}/${P}-dev.tar" "${WORKDIR}"
		cd "${WORKDIR}"
		tar xf "${P}-dev.tar" readme.txt
		tar --delete -f "${P}-dev.tar" readme.txt
	else
		cp "${DISTDIR}/${P}.tar" "${WORKDIR}"
		cd "${WORKDIR}"
		tar xf "${P}.tar" readme.txt
		tar --delete -f "${P}.tar" readme.txt
	fi
}

src_install() {
#	rm sprites/openttd* sprites/trg*
	insinto "${GAMES_DATADIR}"/openttd/data/
#	doins -r sprites || die
	dodoc readme.txt || die
	if use dev ; then
		doins "${P}-dev.tar" || die
	else
		doins "${P}.tar" || die
	fi
#
#	dosym ogfxe_extra "${GAMES_DATADIR}"/openttd/data/sprites/openttdd || die
#	dosym ogfxe_extra "${GAMES_DATADIR}"/openttd/data/sprites/openttdw || die
#	dosym ogfx1_base "${GAMES_DATADIR}"/openttd/data/sprites/trg1 || die
#	dosym ogfx1_base "${GAMES_DATADIR}"/openttd/data/sprites/trg1r || die
#	dosym ogfxc_arctic "${GAMES_DATADIR}"/openttd/data/sprites/trgc || die
#	dosym ogfxc_arctic "${GAMES_DATADIR}"/openttd/data/sprites/trgcr || die
#	dosym ogfxh_tropical "${GAMES_DATADIR}"/openttd/data/sprites/trgh || die
#	dosym ogfxh_tropical "${GAMES_DATADIR}"/openttd/data/sprites/trghr || die
#	dosym ogfxi_logos "${GAMES_DATADIR}"/openttd/data/sprites/trgi || die
#	dosym ogfxi_logos "${GAMES_DATADIR}"/openttd/data/sprites/trgir || die
#	dosym ogfxt_toyland "${GAMES_DATADIR}"/openttd/data/sprites/trgt || die
#	dosym ogfxt_toyland "${GAMES_DATADIR}"/openttd/data/sprites/trgtr || die
	prepgamesdirs
}
