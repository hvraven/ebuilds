# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="cat & rm in a single tool"
HOMEPAGE="http://jwilk.net/software/hungrycat"
SRC_URI="https://bitbucket.org/jwilk/hungrycat/get/${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="expat"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/tar
app-arch/bzip2"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A} || die
	mv jwilk-${PN}-* ${P} || die
}

src_install() {
	dobin hungrycat || die
	dodoc doc/{README,changelog} || die
}
