# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )
inherit python-r1

DESCRIPTION="sshfp generates DNS SSHFP and DANE records for use with DNSSEC"
HOMEPAGE="http://www.xelerance.com/services/software/sshfp/"
SRC_URI="https://github.com/xelerance/${PN}/archive/${PV}.zip -> ${P}.zip"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-text/xmlto
	${PYTHON_DEPS}"
RDEPEND="dev-python/dnspython"

src_install() {
	python_foreach_impl python_doscript sshfp
	python_foreach_impl python_doscript dane

	dodoc TODO README CHANGES BUGS
	doman dane.1 sshfp.1
}
