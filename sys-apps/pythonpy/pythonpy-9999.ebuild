# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )
inherit bash-completion-r1 distutils-r1 git-r3

DESCRIPTION="python -c, with tab completion and shorthand"
HOMEPAGE="https://github.com/Russell91/pythonpy"
EGIT_REPO_URI="https://github.com/Russell91/pythonpy.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

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
