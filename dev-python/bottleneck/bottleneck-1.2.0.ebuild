# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

MY_PN="Bottleneck"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Fast NumPy array functions written in Cython"
HOMEPAGE="http://berkeleyanalytics.com/bottleneck"
SRC_URI="mirror://pypi/B/${MY_PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	>=dev-python/numpy-1.11.2[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}"/${MY_P}

python_test() {
	cd "${BUILD_DIR}" || die
	${PYTHON} -c "import bottleneck;bottleneck.test(extra_argv=['--verbosity=3'])" || die
}
