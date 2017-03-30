# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )
inherit bash-completion-r1 distutils-r1

DESCRIPTION="python -c, with tab completion and shorthand"
HOMEPAGE="https://github.com/Russell91/pythonpy"
SRC_URI="https://github.com/Russell91/pythonpy/archive/v${PV}.zip -> ${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

src_prepare() {
	# don't autoinstall completion files
	sed -i -e '/package_data=/d' -e '/scripts=/d' setup.py || die

	default
}

src_install() {
	distutils-r1_src_install

	newbashcomp "${FILESDIR}/py.bashcomp" py
	insinto /usr/share/zsh/site-functions
	newins "${FILESDIR}/py.zshcomp" _py
}
