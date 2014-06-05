# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT="python2_7"
inherit python-r1

DESCRIPTION="Package for generating and verifying SSHFP, TLSA and OPENPGP records."
HOMEPAGE="http://people.redhat.com/pwouters/"
SRC_URI="http://people.redhat.com/pwouters/${PN}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="net-dns/unbound[python]
	dev-python/python-gnupg
	dev-python/ipaddr
	dev-python/m2crypto
	net-misc/openssh"

src_install() {
	for bin in openpgpkey sshfp tlsa ; do
		doman ${bin}.1
		python_foreach_impl python_doscript ${bin}
	done

	dodoc README CHANGES BUGS
}
