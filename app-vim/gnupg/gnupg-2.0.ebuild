# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit vim-plugin

DESCRIPTION="open gpg encrypted files directly in vim"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3645"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=15987 ->
${P}.vim"

LICENSE="GPL 2.0"
SLOP=0
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

#S="${WORKDIR}"

src_unpack() {
	mkdir -p "${S}"/plugin || die
	cp -v "${DISTDIR}"/${P}.vim "${S}"/plugin/${PN}.vim || die
}
