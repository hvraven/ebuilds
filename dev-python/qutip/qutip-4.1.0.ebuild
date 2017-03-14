# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6} )
inherit distutils-r1

DESCRIPTION="Simulating dynamics of open quantum systems in Python."
HOMEPAGE="http://qutip.org"
SRC_URI="http://qutip.org/downloads/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="openmp test"

RDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )
"

src_prepare() {
	sed -i setup.py \
		-e 's/_compiler_flags = .*$/_compiler_flags = []/' || die

	default
}

python_configure_all() {
	if use openmp ; then
		mydistutilsargs=( --with-openmp )
	fi
}

python_test() {
	cd "${BUILD_DIR}"/lib* || die
	${PYTHON} -c "import qutip.testing as qt ; qt.run()" || die
}
