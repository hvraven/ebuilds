# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools

DESCRIPTION="cat & rm in a single tool"
HOMEPAGE="http://jwilk.net/software/hungrycat"
SRC_URI="https://bitbucket.org/jwilk/hungrycat/get/${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-arch/tar
	app-arch/bzip2"
RDEPEND="${DEPEND}"

src_unpack() {
	default
	mv jwilk-hungrycat-* ${P} || die
}

src_prepare() {
	eautoreconf
}
