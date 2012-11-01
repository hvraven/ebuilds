# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

WX_GTK_VER=2.8

inherit eutils wxwidgets

DESCRIPTION="a LGPL-ed pc emulator"
HOMEPAGE="http://bochs.sourceforge.net/"
SRC_URI="mirror://sourceforge/bochs/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="3dnow avx cdrom debugger doc e1000 gameport ncurses readline svga sdl +smp usb wxwidgets vnc X"

RDEPEND="X? ( x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXpm )
	sdl? ( media-libs/libsdl )
	svga? ( media-libs/svgalib )
	wxwidgets? ( x11-libs/wxGTK:2.8[X] )
	readline? ( sys-libs/readline )
	ncurses? ( sys-libs/ncurses )"

DEPEND="${RDEPEND}
	doc? ( app-text/docbook-sgml-utils )
	X? ( x11-proto/xproto )
	sys-apps/sed
	>=app-text/opensp-1.5"

src_prepare() {
	# fix hardcoded doc path ignoring PV
	sed -i "s/^docdir.*/docdir = ${EPREFIX}\/usr\/share\/doc\/${PF}/" \
		Makefile.in || die "sed failed"
}

src_configure() {
	use wxwidgets && \
		need-wxwidgets unicode

	econf \
		--enable-all-optimizations \
		--enable-idle-hack \
		--enable-disasm \
		--enable-raw-serial \
		--enable-clgd54xx \
		--enable-monitor-mwait \
		--enable-iodebug \
		--prefix=/usr \
		--enable-ne2000 \
		--enable-sb16=linux \
		--enable-plugins \
		--enable-pci \
		--enable-pcidev \
		--enable-pnic \
		--enable-cpu-level=6 \
		--with-nogui \
		$(use_enable 3dnow) \
		$(use_enable amd64 x86-64) \
		$(use_enable avx) \
		$(use_enable cdrom) \
		$(use_enable debugger) \
		$(use_enable doc docbook) \
		$(use_enable e1000) \
		$(use_enable gameport) \
		$(use_enable readline) \
		$(use_enable smp) \
		$(use_enable usb) \
		$(use_enable usb usb-ohci) \
		$(use_enable usb usb-xhci) \
		$(use_with ncurses term) \
		$(use_with sdl) \
		$(use_with svga) \
		$(use_with vnc rfb) \
		$(use_with wxwidgets wx) \
		$(use_with X x) \
		$(use_with X x11) \
		${myconf}
}

#src_install() {
#	make DESTDIR="${D}" install unpack_dlx || die "make install failed"

	# workaround
#	make prefix="${D}/usr" install_dlx

#	dodoc \
#		CHANGES \
#		PARAM_TREE.txt \
#		README \
#		README-plugins \
#		TESTFORM.txt \
#		TODO || \
#		die "doco failed"

#	if [ use vnc ]
#	then
#		dodoc README.rfb || die "dodoc failed"
#	fi

#	if [ use wxwidgets ]
#	then
#		dodoc README-wxWindows || die "dodoc failed"
#	fi
#}
