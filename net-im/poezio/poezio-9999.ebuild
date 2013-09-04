# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{3_1,3_2,3_3} )

inherit distutils-r1 git-2

DESCRIPTION="Console XMPP client"
HOMEPAGE="http://poez.io/"
EGIT_REPO_URI="http://git.louiz.org/poezio"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="dev-python/dnspython3[${PYTHON_USEDEP}]
	~dev-python/sleekxmpp-9999[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
