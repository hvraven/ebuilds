# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dnspython/dnspython-1.10.0-r1.ebuild,v 1.1 2013/05/29 17:09:00 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{3_1,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="DNS toolkit for Python 3"
HOMEPAGE="http://www.dnspython.org/ http://pypi.python.org/pypi/dnspython"
SRC_URI="http://www.dnspython.org/kits3/${PV}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples test"

DEPEND="dev-python/pycrypto[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

DOCS=( ChangeLog README )

python_prepare_all() {
	use test && DISTUTILS_IN_SOURCE_BUILD=1
	distutils-r1_python_prepare_all
}

python_test() {
	pushd "${BUILD_DIR}"/../tests &> /dev/null
	local test
	for test in *.py; do
		if ! "${PYTHON}" ${test}; then
			die "test $test failed under ${EPYTHON}"
		else
			einfo "test $test"
		fi
	done
	# make some order out of the output salad
	einfo "Testsuite passed under ${EPYTHON}"
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
