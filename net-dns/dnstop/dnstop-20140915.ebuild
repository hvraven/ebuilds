# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit autotools eutils

DESCRIPTION="Displays various tables of DNS traffic on your network"
HOMEPAGE="http://dnstop.measurement-factory.com/"
SRC_URI="http://dnstop.measurement-factory.com/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~x86"
IUSE="ipv6"

RDEPEND="sys-libs/ncurses:=
	net-libs/libpcap[ipv6?]"
DEPEND="${RDEPEND}"

PATCHES="${FILESDIR}/${PN}-pkg-config.patch"

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable ipv6)
}

src_install() {
	dobin dnstop
	doman dnstop.8
	dodoc CHANGES
}
