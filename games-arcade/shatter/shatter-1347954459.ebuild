# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils games unpacker

DESCRIPTION="A retro-inspired brick-breaking game with modern elements"
HOMEPAGE="http://www.shattergame.com/"
SRC_URI="${PN}-linux-${PV}.sh"

LICENSE="shatter"
SLOT="0"
KEYWORDS="~x86 ~amd64 -*"
IUSE=""

RESTRICT="fetch strip"

DEPEND=""
RDEPEND="${DEPEND}"

pkg_nofetch() {
	elog "Please download"
	elog "	${SRC_URI}"
	elog "from ${HOMEPAGE} and place it in ${DISTDIR}"
}

src_unpack() {
	unpack_makeself

	mkdir -p "${S}"
	tar --lzma -xf instarchive_all -C "${S}" || die
	tar --lzma -xf instarchive_linux_all -C "${S}" || die
}

src_install() {
	insinto "${GAMES_PREFIX_OPT}/${P}"
	exeinto "${GAMES_PREFIX_OPT}/${P}"
	doexe Shatter.bin.x86
	doexe SettingsEditor.bin.x86
	doins pkcmn.pak
	doins -r data
	doins -r lib

	dosym "${GAMES_PREFIX_OPT}/${P}/Shatter.bin.x86" "${GAMES_BINDIR}/${PN}"
	dosym "${GAMES_PREFIX_OPT}/${P}/SettingsEditor.bin.x86" \
		"${GAMES_BINDIR}/${PN}-settings"
	make_desktop_entry "${GAMES_PREFIX_OPT}/${P}/Shatter.bin.x86" \
		"Shatter" "Shatter" "Game"
	make_desktop_entry "/${GAMES_PREFIX_OPT}/${P}/SettingsEditor.bin.x86" \
		"Shatter Settings" "Shatter" "Game"
	doicon Shatter.png

	dodoc README.linux
}
