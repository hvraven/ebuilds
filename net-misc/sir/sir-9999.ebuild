# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python3_4 python3_5 )

inherit git-r3 python-r1 user

DESCRIPTION="Automated TLS certificate roll-over and TLSA updates."
HOMEPAGE="https://github.com/Skrupellos/sir"
EGIT_REPO_URI="https://github.com/Skrupellos/sir"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="${PYTHON_DEPS}
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewuser sirpub
	enewuser sirpriv
	enewuser sirns
}

src_install() {
	python_foreach_impl python_newscript ${PN}.py ${PN}
	python_foreach_impl python_domodule ${PN}

	insinto /etc/sir
	newins examples/conf.yaml conf.yaml.example

	keepdir /etc/sir/{rollover,sign}
	keepdir /var/lib/sir/{keys,csrs,certs,chains}
}
