# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils flag-o-matic

DESCRIPTION="A re-implementation of RollerCoaster Tycoon 2"
HOMEPAGE="https://openrct2.org/"
SRC_URI="https://github.com/OpenRCT2/OpenRCT2/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+multiplayer libressl opengl test truetype +twitch"

RDEPEND="app-arch/bzip2
	media-libs/libsdl2
	sys-libs/zlib
	dev-libs/jansson
	media-libs/libpng:=
	media-libs/speexdsp
	multiplayer? (
		!libressl? ( dev-libs/openssl:= )
		libressl? ( dev-libs/libressl:= )
		net-misc/curl[ssl]
	)
	opengl? ( virtual/opengl )
	truetype? (
		media-libs/fontconfig
		media-libs/sdl2-ttf
	)
	twitch? ( net-misc/curl[ssl] )
	games-strategy/openrct2-title-sequences
	"
DEPEND="${RDEPEND}
	test? ( dev-cpp/gtest )"

S="$WORKDIR/OpenRCT2-$PV"

PATCHES=( "$FILESDIR/$PN-0.0.7-remove-external-gtest.patch" )

src_prepare() {
	# remove automatic download of title sequences
	sed -e '/title-sequences/d' -i CMakeLists.txt || die

	default
}

src_configure() {
	# multiplayer support also requires twitch support
	local disable_http=yes
	if use multiplayer || use twitch ; then
		disable_http=no
	fi

	local mycmakeargs=(
		-DDISABLE_OPENGL=$(usex !opengl)
		-DDISABLE_HTTP_TWITCH=$disable_http
		-DDISABLE_NETWORK=$(usex !multiplayer)
		-DDISABLE_TTF=$(usex !truetype)
		-DWITH_TESTS=$(usex test)
	)

	# workaround a missing definition for speexdsp
	append-cppflags -DHAVE_STDINT_H

	cmake-utils_src_configure
}

pkg_postinst() {
	elog "You will require the original game assets to play. See:"
	elog "https://github.com/OpenRCT2/OpenRCT2/wiki/Required-RCT2-files"
}
