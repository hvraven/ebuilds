# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="Embedded Linux Build Environment"
HOMEPAGE="https://elbe-rfs.org"
SRC_URI="https://github.com/Linutronix/elbe/archive/releases/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="
	app-emulation/qemu
	app-misc/tmux
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/mako[${PYTHON_USEDEP}]
	dev-python/suds[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	app-text/xmlto
	doc? (
		app-text/asciidoc
		app-text/pandoc
	)"

S="${WORKDIR}/elbe-releases-v${PV}"

src_prepare() {
	sed -i setup.py -e '/output =/,/output/d' || die

	distutils-r1_src_prepare
}

python_compile() {
	distutils-r1_python_compile

	if use doc ; then
		pushd docs || die
		emake all
		popd
	fi
}

python_install() {
	distutils-r1_python_install

	if use doc ; then
		pushd docs || die
		emake install
		popd
	fi
}
