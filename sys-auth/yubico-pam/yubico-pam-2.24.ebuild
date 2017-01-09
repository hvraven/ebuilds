# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
#!/bin/bash

EAPI=5

inherit autotools eutils pam

DESCRIPTION="PAM authentication with Yubico Yubikeys"
HOMEPAGE="https://github.com/Yubico/yubico-pam"
SRC_URI="https://github.com/Yubico/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+challenge-response ldap test"

RDEPEND="sys-auth/libyubikey
	>=sys-auth/ykclient-2.15
	sys-libs/pam
	challenge-response? ( sys-auth/ykpers )
	ldap? ( net-nds/openldap )"
DEPEND="${RDEPEND}
	test? ( ldap? ( dev-perl/Net-LDAP-Server ) )"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--with-pam-dir=$(getpam_mod_dir) \
		$(use_with challenge-response cr) \
		$(use_with ldap)
}

src_test() {
	emake check || die
}

src_install() {
	default

	prune_libtool_files --modules
}
