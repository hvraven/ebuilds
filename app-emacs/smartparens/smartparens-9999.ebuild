# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 elisp

DESCRIPTION="Minor mode that deals with parens pairs."
HOMEPAGE="https://github.com/Fuco1/smartparens"
EGIT_REPO_URI="https://github.com/Fuco1/smartparens.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND="app-emacs/dash"
RDEPEND="${DEPEND}"

src_unpack() {
	git-2_src_unpack
	elisp_src_unpack
}
