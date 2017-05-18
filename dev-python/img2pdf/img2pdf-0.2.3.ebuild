# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )
inherit distutils-r1

DESCRIPTION="Convert images to PDF via direct JPEG inclusion"
HOMEPAGE="https://pypi.python.org/pypi/img2pdf"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pdfrw[${PYTHON_USEDEP}]"

python_test() {
	esetup.py test
}
