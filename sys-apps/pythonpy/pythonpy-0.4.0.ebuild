# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
#!/bin/bash

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )
inherit bash-completion-r1 distutils-r1 vcs-snapshot

COMMIT=22fca19952c391f1665a2f1448e75dc2202b994a

DESCRIPTION="python -c, with tab completion and shorthand"
HOMEPAGE="https://github.com/Russell91/pythonpy"
SRC_URI="https://github.com/Russell91/pythonpy/tarball/$COMMIT -> $P.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
	# remove broken check for completion dirs
	sed -i -e '/tempfile.TemporaryFile/d' setup.py || die
}

src_install() {
	distutils-r1_src_install

	rm -r "${D}/usr/bash_completion.d"
	newbashcomp "${FILESDIR}/py.bashcomp" py
	insinto /usr/share/zsh/site-functions
	newins "${FILESDIR}/py.zshcomp" _py
}
