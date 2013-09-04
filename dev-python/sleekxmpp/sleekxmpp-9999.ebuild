# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sleekxmpp/sleekxmpp-1.1.11.ebuild,v 1.1 2013/04/23 05:38:02 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} )

inherit eutils distutils-r1 git-2

DESCRIPTION="Python library for XMPP"
HOMEPAGE="http://sleekxmpp.com/ https://github.com/fritzy/SleekXMPP/ https://pypi.python.org/pypi/sleekxmpp/"
EGIT_REPO_URI="https://github.com/fritzy/SleekXMPP.git"
EGIT_BRANCH="develop"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="app-crypt/gnupg"

PATCHES=( ${FILESDIR}/${P}-tests-exit-code.patch )

python_test() {
	esetup.py test
}
