# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1 mercurial

DESCRIPTION="Compiler of NML files into grf/nfo files"
HOMEPAGE="https://dev.openttdcoop.org/projects/nml"
EHG_REPO_URI="https://hg.openttdcoop.org/nml"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="virtual/python-imaging[$PYTHON_USEDEP]
	dev-python/ply[$PYTHON_USEDEP]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( docs/{changelog,readme}.txt )

src_install() {
	distutils-r1_src_install
	doman docs/nmlc.1
}
