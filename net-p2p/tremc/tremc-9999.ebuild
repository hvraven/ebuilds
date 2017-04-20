# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5} )
PYTHON_REQ_USE="ncurses"
inherit bash-completion-r1 python-r1 git-r3

DESCRIPTION="Ncurses interface for the Transmission BitTorrent client"
HOMEPAGE="https://github.com/louipc/tremc"
EGIT_REPO_URI="https://github.com/louipc/tremc.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="geoip"

RDEPEND="${PYTHON_DEPS}
	geoip? ( dev-python/geoip-python[$PYTHON_USEDEP] )
"

src_install() {
	python_foreach_impl python_doscript ${PN}
	newbashcomp completion/bash/transmission-remote-cli-bash-completion.sh \
		${PN}
	insinto /usr/share/zsh/site-functions
	newins completion/zsh/_transmission-remote-cli _${PN}
	doman ${PN}.1
	dodoc NEWS README.md
}
