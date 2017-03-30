# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6} )
inherit distutils-r1

DESCRIPTION="Interactive plotting for the Jupyter notebook."
HOMEPAGE="https://github.com/bloomberg/bqplot"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/ipywidgets-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/traitlets-4.3.0[${PYTHON_USEDEP}]
	>=dev-python/traittypes-0.0.6[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.10.4[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
