# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )
inherit distutils-r1

DESCRIPTION="TUI and CLI for the BitTorrent client Transmission"
HOMEPAGE="https://github.com/rndusr/stig"
SRC_URI="https://github.com/rndusr/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="geoip test"

RDEPEND=">=dev-python/urwid-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/urwidtrees-1.0.3_pre0[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-0.22.5[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/blinker[${PYTHON_USEDEP}]
	geoip? ( dev-python/geoip-python[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	test? (
		dev-python/asynctest[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)"

python_test() {
	nosetests || die
}
