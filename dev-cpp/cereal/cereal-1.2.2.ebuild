# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="C++11 library for serialization"
HOMEPAGE="http://uscilab.github.io/cereal/"
SRC_URI="https://github.com/USCiLab/cereal/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test threads"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-libs/boost )
	doc? ( app-doc/doxygen )"

src_prepare() {
	use test || cmake_comment_add_subdirectory unittests
	use test || cmake_comment_add_subdirectory sandbox
	use doc || cmake_comment_add_subdirectory doc

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_WERROR=OFF
		-DTHREAD_SAFE=$(usex threads)
	)

	cmake-utils_src_configure
}
