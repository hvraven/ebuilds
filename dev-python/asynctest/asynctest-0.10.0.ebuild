# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )
inherit distutils-r1

DESCRIPTION="Features for testing asyncio libraries."
HOMEPAGE="https://github.com/Martiusweb/asynctest/"
SRC_URI="https://github.com/Martiusweb/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

python_test() {
	${eYTHON} -m unittest test || die
}
