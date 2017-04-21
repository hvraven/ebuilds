# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

MY_PV=$PV.dev0
MY_P=$PN-$MY_PV

DESCRIPTION="Tree widgets for urwid"
HOMEPAGE="https://github.com/pazz/urwidtrees"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/urwid-1.1.0[${PYTHON_USEDEP}]"

S="$WORKDIR/$MY_P"

src_prepare() {
	find "${S}" -name '*.py' -print0 | xargs -0 -- sed \
		-e '1i# -*- coding: utf-8 -*-' -i || die

	distutils-r1_src_prepare
}
