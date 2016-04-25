# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit cmake-multilib

DESCRIPTION="The Portable OpenGL FrameWork"
HOMEPAGE="http://www.glfw.org/"
SRC_URI="mirror://sourceforge/glfw/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="3"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="egl examples"

RDEPEND="x11-libs/libXrandr[${MULTILIB_USEDEP}]
	x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libXi[${MULTILIB_USEDEP}]
	x11-libs/libXxf86vm[${MULTILIB_USEDEP}]
	x11-libs/libXinerama[${MULTILIB_USEDEP}]
	x11-libs/libXcursor[${MULTILIB_USEDEP}]
	virtual/opengl[${MULTILIB_USEDEP}]
	!media-libs/glfw:0"
DEPEND=${RDEPEND}

multilib_src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use egl GLFW_USE_EGL)
		$(cmake-utils_use examples GLFW_BUILD_EXAMPLES)
		-DBUILD_SHARED_LIBS=1
	)
	cmake-utils_src_configure
}
