# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
#!/bin/bash

EAPI=6

inherit eutils dotnet multilib

MY_PN="CKAN"
DESCRIPTION="Client for the Comprehensive Kerbal Archive Network"
HOMEPAGE="https://github.com/KSP-CKAN/CKAN"
SRC_URI="https://github.com/KSP-CKAN/CKAN/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lang/mono
	net-misc/curl[ssl]
	dev-dotnet/log4net"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	default

	# remove git calls from bin/build since the tarball doesn't contain
	# the git repo
	sed -i bin/build \
		-e "s/my \$VERSION.*/my \$VERSION = \"${PV}\";/" \
		-e 's/my $branch.*/my $branch = "";/' || die

	# remove bundled libraries
	# TODO: NUnit CommandlineParser SharpZipLib Newtonsoft.Json
	# these exist in the dotnet overlay but that does magic things which
	# don't work
	# More TODO: CurlSharp autofac ChinhDo.Transactions
	rm -r {Core,CKAN}/packages/log4net* || die

	sed -e 's;/verbosity:minimal;;i' -i build.sh || die
}

src_install() {
	insinto /usr/$(get_libdir)/${PN}/

	for bin in ckan netkan ; do
		make_wrapper $bin "mono /usr/$(get_libdir)/${PN}/${bin}.exe" || die
		doins ${bin}.exe
	done

	for size in 16 32 48 64 96 128 256 ; do
		newicon -s $size GUI/assets/ckan-${size}.png ckan.png || die
	done

	make_desktop_entry ${PN} ${MY_PN} ${PN} || die
}
