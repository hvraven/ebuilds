# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit bzr vala

DESCRIPTION="graphical front-end for conky config files"
HOMEPAGE="http://www.teejeetech.in/p/conky-manager.html"
# upstream doesn't provide tarballs
EBZR_REVISION=102
EBZR_REPO_URI="lp:conky-manager"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

COMMON_DEPS="
	x11-libs/gtk+:3
	dev-libs/libgee:0
	dev-libs/json-glib
	dev-libs/glib:2
	net-libs/libsoup:2.4"
DEPEND="${COMMON_DEPS}
	$(vala_depend)"
RDEPEND="${COMMON_DEPS}
	app-admin/conky[imlib,lua,lua-cairo,lua-imlib]
	app-arch/p7zip"

src_prepare() {
	vala_src_prepare

	sed -i \
		-e '/^CFLAGS/d' \
		-e 's/valac/$(VALAC)/g' \
		src/makefile || die

	# fix QA warnings in the distributed .desktop file
	sed -i \
		-e 's/^Caption/X-Caption/' \
		-e 's/^\(Categories.*$\)/\1;/' \
		src/${PN}.desktop || die
}
