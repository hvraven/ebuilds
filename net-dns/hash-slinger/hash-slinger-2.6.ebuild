# Copyright 1999-2015 Gentoo Foundation
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
IUSE="+gnupg ipsec +sshfp"

DEPEND=""
RDEPEND="net-dns/unbound[python,$PYTHON_USEDEP]
	dev-python/ipaddr[$PYTHON_USEDEP]
	dev-python/m2crypto[$PYTHON_USEDEP]
	gnupg? ( dev-python/python-gnupg[$PYTHON_USEDEP] )
	ipsec? ( net-misc/libreswan )
	sshfp? ( net-misc/openssh )"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_install() {
	local progs
	progs=tlsa
	use sshfp && progs="$progs sshfp"
	use gnupg && progs="$progs openpgpkey"
	use ipsec && progs="$progs ipsec"
	for bin in $progs ; do
		doman ${bin}.1
		python_foreach_impl python_doscript ${bin}
	done

	dodoc README CHANGES BUGS
}
