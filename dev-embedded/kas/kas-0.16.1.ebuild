# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )
inherit distutils-r1

DESCRIPTION="Setup tool for bitbake based projects"
HOMEPAGE="https://github.com/siemens/kas"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/distro[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-2.5[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
