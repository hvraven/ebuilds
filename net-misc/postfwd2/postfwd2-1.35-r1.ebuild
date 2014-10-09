# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit user

DESCRIPTION="Firewall daemon for the postfix mta"
HOMEPAGE="http://postfwd.org/"
SRC_URI="http://postfwd.org/${P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-perl/net-server
	dev-perl/Net-DNS
	virtual/perl-Time-HiRes
	virtual/perl-Storable"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup postfwd
	enewuser postfwd -1 -1 -1 postfwd
}

src_unpack() {
	mkdir -p "${S}"
	cp "${DISTDIR}/${P}" "${S}" || die
}

src_install() {
	newbin ${P} ${PN}
	newinitd "${FILESDIR}/postfwd2.rc6" ${PN}
	newconfd "${FILESDIR}/postfwd2.conf" ${PN}
}
