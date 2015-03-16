# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{3_3,3_4} )

inherit distutils-r1 eutils mercurial

DESCRIPTION="Compiler of NML files into grf/nfo files"
HOMEPAGE="https://dev.openttdcoop.org/projects/nml"
EHG_REPO_URI="https://hg.openttdcoop.org/nml"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/pillow[zlib,${PYTHON_USEDEP}]
	dev-python/ply[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( docs/{changelog,readme}.txt )

src_prepare() {
	epatch "${FILESDIR}/${P}-setup.py-add-missing-packages.patch"
	epatch_user
}

src_install() {
	distutils-r1_src_install
	doman docs/nmlc.1
}
