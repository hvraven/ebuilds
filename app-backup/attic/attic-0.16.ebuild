# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
#!/bin/bash

EAPI=5
PYTHON_COMPAT=( python{3_2,3_3,3_4} )

inherit distutils-r1

MY_PN=Attic
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Attic is a deduplicating backup program written in Python"
HOMEPAGE="https://attic-backup.org"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="fuse"

S="${WORKDIR}/${MY_P}"

DEPEND="${PYTHON_DEPS}
	dev-python/msgpack[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	fuse? ( dev-python/llfuse[${PYTHON_USEDEP}] )"
RDEPEND="${DEPEND}"
