# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
#!/bin/bash

EAPI=5

inherit eutils savedconfig

DESCRIPTION="lightweight session manager with {de,at}tach support."
HOMEPAGE="http://www.brain-dump.org/projects/abduco/"
SRC_URI="http://www.brain-dump.org/projects/abduco/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e 's:^PREFIX.*:PREFIX = /usr:' \
		-e 's/-Os//' \
		-e '/^CC/d' \
		config.mk || die

	sed -i \
		-e '/@echo CC/d' \
		-e 's|@${CC}|$(CC)|g' \
		Makefile || die

	restore_config config.def.h
	epatch_user
}

src_test() {
	./testsuite.sh
}

src_install() {
	dobin ${PN}
	dodoc README
	doman ${PN}.1

	save_config config.def.h
}
