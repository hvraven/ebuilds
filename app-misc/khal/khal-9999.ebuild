# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1 git-2

DESCRIPTION="CLI calendar application build around CalDAV."
HOMEPAGE="https://github.com/geier/khal"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
KEYWORDS=""
SLOT="0"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	>=dev-python/lxml-2[$PYTHON_USEDEP]
	>=dev-python/requests-0.10[$PYTHON_USEDEP]
	>=dev-python/urwid-0.9[$PYTHON_USEDEP]
	dev-python/pyxdg[$PYTHON_USEDEP]
	dev-python/icalendar[$PYTHON_USEDEP]
	virtual/python-argparse[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

EXAMPLES=( khal.conf.sample )

pkg_postinst() {
	ewarn "Copy and edit the supplied khal.conf.sample file"
	ewarn "(default location is ~/.config/khal/khal.conf)."
	ewarn "Beware that only you can access this file,"
	ewarn "if you have untrusted users on your machine,"
	ewarn "since the password is stored in cleartext."
}

src_install() {
	distutils-r1_src_install
	insinto /usr/share/zsh/site-functions
	doins misc/__khal
}
