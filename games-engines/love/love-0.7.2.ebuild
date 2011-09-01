# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

DESCRIPTION="An unquestionably awesome 2D game engine"
HOMEPAGE="http://love2d.org/"

SRC_URI="https://bitbucket.org/rude/${PN}/downloads/${P}-linux-src.tar.gz ->
${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-games/physfs
	media-libs/devil
	media-libs/libsdl[joystick]
	media-libs/sdl-sound
	media-libs/openal
	media-libs/libmng
	media-libs/libmodplug
	media-sound/mpg123"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-HEAD"
