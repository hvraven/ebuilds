# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
#!/bin/bash

EAPI=5

inherit elisp-common eutils multilib versionator

MY_PV=$(replace_version_separator 2 -)

DESCRIPTION="Mona is a solver for weak second-order logics"
HOMEPAGE="http://www.brics.dk/mona/"
SRC_URI="http://www.brics.dk/mona/download/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="emacs static-libs"

DEPEND="virtual/yacc"
RDEPEND="emacs? ( virtual/emacs )"

S="${WORKDIR}/${PN}-$(get_version_component_range 1-2)"

SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	# remove forced optimizations
	sed -e '/CXXFLAGS/ s/-O3//' \
		-i configure

	# inlining of header defined functions only works with gcc
	epatch "${FILESDIR}/${PN}-remove-inline.patch"
}

src_configure() {
	econf \
		$(use_enable static-libs static)
}

src_compile() {
	default

	if use emacs ; then
		elisp-compile *.el
	fi
}

src_install() {
	default

	# remove libtool files
	rm ${D}/usr/$(get_libdir)/*.la

	rm "${D}/usr/share/mona-mode.el"
	if use emacs ; then
		elisp-install ${PN} *.el
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
