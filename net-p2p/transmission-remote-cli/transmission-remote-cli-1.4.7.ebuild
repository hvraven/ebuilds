# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="ncurses"
inherit bash-completion-r1 python-r1

DESCRIPTION="A ncurses interface for the Transmission BitTorrent client"
HOMEPAGE="https://github.com/fagga/transmission-remote-cli/tree/v1.4.7"
SRC_URI="https://github.com/fagga/${PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="geoip rdns"

# TODO: dev-python/simplejson if python <= 2.5
RDEPEND="${PYTHON_DEPS}
	geoip? ( dev-python/geoip-python )
	rdns? ( dev-python/adns-python )"

src_install() {
	python_foreach_impl python_doscript transmission-remote-cli
	doman transmission-remote-cli.1
	dodoc NEWS README.md
	newbashcomp ${PN}-bash-completion.sh ${PN}
}
