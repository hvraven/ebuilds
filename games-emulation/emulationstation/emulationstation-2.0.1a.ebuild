# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
#!/bin/bash

EAPI=6

inherit cmake-utils flag-o-matic

COMMIT_ID="646bede3d9ec0acf0ae378415edac136774a66c5"
MY_P="EmulationStation"

DESCRIPTION="Flexible emulator front-end supporting keyboardless navigation."
HOMEPAGE="http://www.emulationstation.org"
SRC_URI="https://github.com/Aloshi/${MY_P}/archive/${COMMIT_ID}.zip
	-> ${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gba wii gamecube n64 nes snes atari2600"

PATCHES="${FILESDIR}/emulationstation-2.0.1a-system-pugixml.patch
	${FILESDIR}/emulationstation-2.0.1a-cxxflags.patch"

DEPEND="
	dev-cpp/eigen:3
	dev-libs/boost:=
	dev-libs/pugixml
	media-libs/alsa-lib
	media-libs/freeimage
	media-libs/freetype:2
	media-libs/libsdl2
	net-misc/curl[ssl]
	virtual/opengl
	"
RDEPEND="${DEPEND}
	wii? ( games-emulation/dolphin )
	gamecube? ( games-emulation/dolphin )
	n64? ( games-emulation/mupen64plus )
	nes? ( games-emulation/mednafen )
	snes? ( games-emulation/zsnes )
	atari2600? ( games-emulation/stella )
	gba? ( || (
		games-emulation/visualboyadvance
		games-emulation/mednafen
		) )"

src_unpack() {
	default
	mv ${MY_P}-* ${P} || die
}
