# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit elisp

DESCRIPTION="A modern list api for Emacs. No 'cl required."
HOMEPAGE="https://github.com/magnars/dash.el"
SRC_URI="https://github.com/magnars/dash.el/archive/${PV}.zip"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/dash.el-${PV}"

DEPEND=""
RDEPEND="${DEPEND}"
