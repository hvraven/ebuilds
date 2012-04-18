# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

PYTHON_DEPEND="2:2.5"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="tool to generate grf and nfo files from a meta-language"
HOMEPAGE="https://dev.openttdcoop.org/projects/nml"
SRC_URI="http://bundles.openttdcoop.org/${PN}/releases/${PV}/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/imaging
dev-python/ply"
RDEPEND="${DEPEND}"

DOCS="docs/changelog.txt docs/readme.txt"

pkg_setup() {
	python_set_active_version 2
}

src_install() {
	distutils_src_install
	doman docs/nmlc.1
}
