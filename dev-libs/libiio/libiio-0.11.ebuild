# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit cmake-utils python-single-r1

DESCRIPTION="Library for interfacing with IIO devices."
HOMEPAGE="https://github.com/analogdevicesinc/libiio"
SRC_URI="https://github.com/analogdevicesinc/libiio/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+aio config daemon doc dotnet examples ipv6 +local python remote
serial usb util +xml zeroconf"

RDEPEND="dotnet? ( dev-lang/mono )
	usb? ( virtual/libusb:1 )
	xml? ( dev-libs/libxml2 )
	zeroconf? ( net-dns/avahi )
	daemon? (
		aio? ( dev-libs/libaio )
	)
"
#	config? ( dev-libs/libini )
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )
	daemon? (
		local
		usb? ( aio )
	)
	usb? ( xml )"

src_prepare() {
	# configure fails if any git is found (e.g. /.git)
	sed -i CMakeLists.txt -e '/FindGit/d' || die

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_NETWORK_BACKEND=$(usex remote)
		-DWITH_TESTS=$(usex util)
		-DWITH_IIOD=$(usex daemon)
		-DWITH_LOCAL_BACKEND=$(usex local)
		-DENABLE_IPV6=$(usex ipv6)
		-DPYTHON_BINDINGS=$(usex python)
		-DWITH_LOCAL_CONFIG=$(usex config)
		-DWITH_USB_BACKEND=$(usex usb)
		-DWITH_XML_BACKEND=$(usex xml)
		-DWITH_DOC=$(usex doc)
		-DENABLE_PACKAGING=OFF
		-DINSTALL_UDEV_RULE=ON
		-DCSHARP_BINDINGS=$(usex dotnet)
		-DPYTHON_BINDINGS=$(usex python)
		-DENABLE_AIO=$(usex aio)
		-DENABLE_IIOD_USBD=$(usex usb)
		# TODO add flag to remove automagic zeroconf
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	use examples && dodoc -r examples
}
