# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit elisp

DESCRIPTION="Extensible vi layer for Emacs"
HOMEPAGE="https://bitbucket.org/lyro/evil/wiki/Home"
SRC_URI="https://bitbucket.org/lyro/evil/get/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+ FDL-1.3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=app-emacs/undo-tree-0.6.3"
RDEPEND="${DEPEND}"

ELISP_REMOVE="evil-pkg.el evil-tests.el"
ELISP_TEXINFO="doc/evil.texi"
SITEFILE="50${PN}-gentoo.el"
DOCS="CHANGES.org"

src_unpack() {
	default
	mv lyro-evil-* ${P} || die
}
