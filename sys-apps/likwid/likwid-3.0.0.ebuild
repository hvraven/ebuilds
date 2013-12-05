# Copyright 2013-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils fcaps

DESCRIPTION="Command line tools for developing high performance multi threaded programs"
HOMEPAGE="http://code.google.com/p/likwid/"
SRC_URI="http://likwid.googlecode.com/files/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64"
IUSE="+access-daemon fortran static-libs uncore"

DEPEND="fortran? ( >=sys-devel/gcc-4.2[fortran] )"

S="${WORKDIR}/${P%.?}"

FILECAPS=( cap_sys_rawio /usr/bin/likwid-accessD )

src_prepare() {
	# set configuration options
	sed -i config.mk -e 's:^PREFIX.*:PREFIX=/usr:' || die
	echo 'MANPREFIX = $(PREFIX)/share/man' >> config.mk
	if use access-daemon ; then
		echo 'BUILDDAEMON = true#' >> config.mk
		echo 'ACCESSMODE = accessdaemon#' >> config.mk
	fi
	use fortran && echo 'FORTRAN_INTERFACE = likwid.mod#' >> config.mk
	use static-libs || echo 'SHARED_LIBRARY = true#' >> config.mk
	use uncore && echo 'ENABLE_SNB_UNCORE = true#' >> config.mk

	local DATE=$(grep ^DATE Makefile | awk '{print $3;}')
	sed -i doc/* -e "s/<DATE>/${DATE}/g" \
		-e "s/<VERSION>/${PV}/g" || die

	# fix compiler flags
	sed -i include_GCC.mk -e '/^CC/d' -e '/^AS/d' -e '/^AR/d' \
		-e '/^CFLAGS/d' -e '/^CPPFLAGS/d' \
		-e 's/^FCFLAGS *=\(.*\)/FCFLAGS += \1/' || die
	sed -i src/access-daemon/Makefile \
		-e '/^CC/d' -e 's/^CFLAGS *=\(.*\)/CFLAGS := \1 $(CFLAGS)/' || die

	# verbose building
	sed -i Makefile -e '/^Q/d' || die
}

src_compile() {
	emake
	emake likwid-bench
}

src_install() {
	# make install ignores DESTDIR and uses strange destinations
	dobin likwid-* perl/likwid-* perl/feedGnuplot
	doman doc/*
	dolib liblikwid*
	insinto /usr/include
	doins src/includes/likwid*.h
	use fortran && doins likwid.mod
	insinto /usr/share/${PN}
	doins filters/*
}
