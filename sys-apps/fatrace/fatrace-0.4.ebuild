# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit linux-info

DESCRIPTION="report file access events from all running processes"
HOMEPAGE="https://launchpad.net/fatrace"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="powertop"

RDEPEND="powertop? ( =sys-power/powertop-1.13
	dev-lang/python )"

CONFIG_CHECK="FANOTIFY"

DOC="NEWS"

src_prepare() {
	use powertop && (sed -i "s/powertop-1.13/powertop/g" \
		"${S}/power-usage-report" || die)
}

src_install() {
	dosbin fatrace || die
	doman fatrace.1 || die
	use powertop && (dosbin power-usage-report || die)
}
