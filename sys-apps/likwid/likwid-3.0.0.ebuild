# Copyright 2013-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils fcaps linux-info

DESCRIPTION="Command line tools for developing high performance multi threaded programs"
HOMEPAGE="http://code.google.com/p/likwid/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64"
IUSE="+access-daemon fortran static-libs +suid uncore"

DEPEND="fortran? ( >=sys-devel/gcc-4.2[fortran] )"

CONFIG_CHECK="~X86_MSR"

S="${WORKDIR}/${P%.?}"

src_prepare() {
	# set configuration options
	sed -i config.mk -e 's:^PREFIX.*:PREFIX=/usr:' || die
	echo 'LIBLIKWIDPIN = $(PREFIX)/lib/liblikwidpin.so' >> config.mk
	echo 'LIKWIDFILTERPATH = $(PREFIX)/share/likwid' >> config.mk
	echo 'MANPREFIX = $(PREFIX)/share/man' >> config.mk
	if use access-daemon ; then
		echo 'BUILDDAEMON = true#' >> config.mk
		echo 'ACCESSMODE = accessdaemon#' >> config.mk
		einfo 'Setting default access mode to accessdaemon.'
	else
		echo 'BUILDDAEMON = false#' >> config.mk
		echo 'ACCESSMODE = direct#' >> config.mk
		einfo 'Setting default access mode to direct.'
	fi
	usex fortran 'FORTRAN_INTERFACE = likwid.mod#' '' >> config.mk
	usex static-libs 'SHARED_LIBRARY = false#' \
		'SHARED_LIBRARY = true#' >> config.mk
	usex uncore 'ENABLE_SNB_UNCORE = true#' \
		'ENABLE_SNB_UNCORE = false#' >> config.mk

	# store version data in man pages
	sed -i doc/* -e 's/<DATE>/29.11.2012/g' \
		-e "s/VERSION/${PV}/g" || die

	# fix compiler flags
	sed -i include_GCC.mk -e '/^CC/d' -e '/^AS/d' -e '/^AR/d' \
		-e '/^CFLAGS/d' -e '/^CPPFLAGS/d' \
		-e 's/^FCFLAGS *=\(.*\)/FCFLAGS += \1/' || die
	sed -i src/access-daemon/Makefile \
		-e '/^CC/d' -e 's/^CFLAGS *=\(.*\)/CFLAGS := \1 $(CFLAGS)/' || die

	# overwrite mempolicy and schedaffinity checks
	if kernel_is -ge 3 7 ; then
		echo 'HAS_MEMPOLICY = 1' >> config.mk
	else
		echo 'HAS_MEMPOLICY = 0' >> config.mk
	fi
	# all glibc versions in tree support schedaffinity
	echo 'HAS_SCHEDAFFINITY = 1' >> config.mk

	# verbose building
	sed -i Makefile -e '/^Q/d' || die
}

src_compile() {
	default
	emake likwid-bench
}

src_install() {
	# make install ignores DESTDIR and uses strange destinations
	dobin likwid-* perl/likwid-* perl/feedGnuplot
	dolib liblikwid*
	insinto /usr/include
	doins src/includes/likwid*.h
	use fortran && doins likwid.mod
	insinto /usr/share/${PN}
	doins filters/*

	doman doc/*
}

pkg_postinst() {
	if use suid ; then
		MODE=4711
	else
		MODE=0711
		einfo 'suid is disabled.'
		einfo 'suid and filecaps are required to run some likwid tools as user.'
	fi

	if use access-daemon ; then
		fcaps -m $MODE -M $MODE cap_sys_rawio /usr/bin/likwid-accessD
	else
		fcaps -m $MODE -M $MODE cap_sys_rawio \
			/usr/bin/likwid-{perfctr,bench,powermeter}
	fi
}
