# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="X Binary Package System from voidlinux"
HOMEPAGE="https://github.com/voidlinux/xbps"
EGIT_REPO_URI="https://github.com/voidlinux/xbps.git"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="debug doc libressl static-libs test"

RDEPEND=">=app-arch/libarchive-2.8.0
	sys-libs/zlib
	!libressl? ( dev-libs/openssl:= )
	libressl? ( dev-libs/libressl:= )"
DEPEND="${RDEPEND}
	doc? (
		app-doc/doxygen
		media-gfx/graphviz
	)
	test? (
		>=dev-libs/atf-0.15
		dev-util/kyua
	)"

src_prepare() {
	# remove -Werror
	sed -e 's/error//g' -i configure

	default
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable doc api-docs) \
		$(use_enable test tests) \
		--verbose
}

src_install() {
	default

	use static-libs || rm "${D}/usr/$(get_libdir)/libxbps.a" || die
}
