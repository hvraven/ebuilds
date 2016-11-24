# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
#!/bin/bash

EAPI=6

inherit eutils

DESCRIPTION="Deductive database system for the Datalog logic language."
HOMEPAGE="http://datalog.sourceforge.net/"
SRC_URI="https://sourceforge.net/projects/datalog/files/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static"

DEPEND="dev-lang/lua:0
	sys-libs/readline:0"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		--with-lua \
		--enable-shared \
		$(use_enable static)
}

src_install() {
	default

	prune_libtool_files --all
}
