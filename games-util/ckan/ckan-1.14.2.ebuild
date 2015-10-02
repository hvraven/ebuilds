# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games eutils mono-env multilib

MY_PN="CKAN"
DESCRIPTION="Client for the Comprehensive Kerbal Archive Network"
HOMEPAGE="https://github.com/KSP-CKAN/CKAN"
SRC_URI="https://github.com/KSP-CKAN/CKAN/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lang/mono
	net-misc/curl[ssl]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	insinto /usr/$(get_libdir)/${PN}/

	for bin in ckan netkan ; do
		make_wrapper $bin "mono /usr/$(get_libdir)/${PN}/${bin}.exe"
		doins ${bin}.exe
	done

	for size in 16 32 48 64 96 128 256 ; do
		newicon -s $size GUI/assets/ckan-${size}.png ckan.png
	done

	make_desktop_entry ${PN} ${MY_PN} ${PN}
}
