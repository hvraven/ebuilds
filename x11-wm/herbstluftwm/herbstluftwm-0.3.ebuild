# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="a manual tiling window manager"
HOMEPAGE="http://wwwcip.cs.fau.de/~re06huxa/herbstluftwm/"
SRC_URI="http://wwwcip.cs.fau.de/~re06huxa/${PN}/tarballs/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="bash-completion doc examples zsh-completion"

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"

src_install() {
	dobin herbstluftwm
	dobin ipc-client/herbstclient
	dodoc BUGS NEWS README
	doman doc/herbstclient.1
	doman doc/herbstluftwm.1

	exeinto /etc/xdg/${PN}
	doexe share/autostart
	doexe share/panel.sh
	doexe share/restartpanels.sh

	insinto /usr/share/xsessions
	doins share/herbstluftwm.desktop

	if use bash-completion ; then
		insinto /etc/bash_completion.d
		doins share/herbstclient-completion
	fi
	if use doc ; then
		dohtml doc/*.html
	fi
	if use examples ; then
		docinto examples
		dodoc scripts/README
		dodoc scripts/*.sh
	fi
	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions/
		doins share/_herbstclient
	fi
}
