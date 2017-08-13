# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )
inherit distutils-r1

DESCRIPTION="Generate multi-unit schematic symbols for KiCad from a CSV file."
HOMEPAGE="https://pypi.python.org/pypi/kipart"
SRC_URI="mirror://pypi/k/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-python/affine-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/future-0.15[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

python_prepare_all() {
	# exclude tests directory from beeing installed
	sed -e "s/find_packages()/find_packages(exclude=['tests'])/" \
		-i setup.py || die

	distutils-r1_python_prepare_all
}
