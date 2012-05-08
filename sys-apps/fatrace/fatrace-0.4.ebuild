# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="powertop? *"
inherit linux-info python

DESCRIPTION="report file access events from all running processes"
HOMEPAGE="https://launchpad.net/fatrace"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="powertop"

RDEPEND="powertop? ( =sys-power/powertop-1.13 )"

CONFIG_CHECK="FANOTIFY"

src_prepare() {
	if use powertop ; then
		sed -e "s/powertop-1.13/powertop/g" \
			-i "${S}"/power-usage-report || die
	fi"
}

src_install() {
	dosbin fatrace
	use powertop && dosbin power-usage-report

	doman fatrace.1
	dodoc NEWS	
}