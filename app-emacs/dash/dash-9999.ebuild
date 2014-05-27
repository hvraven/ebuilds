# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit elisp git-2

DESCRIPTION="A modern list api for Emacs. No 'cl required."
HOMEPAGE="https://github.com/magnars/dash.el"
EGIT_REPO_URI="https://github.com/magnars/dash.el.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	git-2_src_unpack
	elisp_src_unpack
}
