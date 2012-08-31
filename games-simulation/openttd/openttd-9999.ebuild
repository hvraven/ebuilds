# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/openttd/openttd-1.1.2_rc2.ebuild,v 1.1 2011/07/07 17:42:33 mr_bones_ Exp $

EAPI=2
inherit eutils games subversion

DESCRIPTION="OpenTTD is a clone of Transport Tycoon Deluxe"
HOMEPAGE="http://www.openttd.org/"
SRC_URI=""

ESVN_REPO_URI="svn://svn.openttd.org/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="aplaymidi debug dedicated iconv icu lzo +openmedia +png +timidity +truetype zlib"

DEPEND="
	!dedicated? (
		media-libs/libsdl[audio,X,video]
		icu? ( dev-libs/icu )
		truetype? (
			media-libs/fontconfig
			media-libs/freetype:2
			sys-libs/zlib
		)
	)
	lzo? ( dev-libs/lzo:2 )
	iconv? ( virtual/libiconv )
	png? ( media-libs/libpng )
	"
RDEPEND="
	!dedicated? (
		openmedia? (
			games-misc/openmsx
			games-misc/opensfx
		)
		aplaymidi? ( media-sound/alsa-utils )
		!aplaymidi? ( timidity? ( media-sound/timidity++ ) )
	)
	openmedia? ( games-misc/opengfx )
	"

PATCHES=( "${FILESDIR}"/${P}-cflags.patch )

src_prepare() {
	subversion_src_prepare
	# fix to help the automatic revision detection
	echo "r${ESVN_WC_REVISION}	${ESVN_WC_REVISION}	0	r${ESVN_WC_REVISION}" \
		> "${S}/.ottdrev"
}

src_configure() {
	# there is an allegro interface available as well as sdl, but
	# the configure for it looks broken so the sdl interface is
	# always built instead.
	local myopts="${myopts} --without-allegro"

	# libtimidity not needed except for some embedded platform
	# nevertheless, it will be automagically linked if it is
	# installed. Hence, we disable it.
	myopts="${myopts} --without-libtimidity"

	use debug && myopts="${myopts} --enable-debug=3"

	if use dedicated ; then
		myopts="${myopts} --enable-dedicated"
	else
		use aplaymidi && myopts="${myopts} --with-midi='/usr/bin/aplaymidi'"
		myopts="${myopts}
			$(use_with truetype freetype)
			$(use_with icu)
			--with-sdl"
	fi
	if use png || { use !dedicated && use truetype; } || use zlib ; then
		myopts="${myopts} --with-zlib"
	else
		myopts="${myopts} --without-zlib"
	fi

	# configure is a hand-written bash-script, so econf will not work.
	# It's all built as C++, upstream uses CFLAGS internally.
	CFLAGS="" ./configure \
		--disable-strip \
		--prefix-dir="${EPREFIX}" \
		--binary-dir="${GAMES_BINDIR}" \
		--data-dir="${GAMES_DATADIR}/${PN}" \
		--install-dir="${D}" \
		--icon-dir=/usr/share/pixmaps \
		--menu-dir=/usr/share/applications \
		--icon-theme-dir=/usr/share/icons/hicolor \
		--man-dir=/usr/share/man/man6 \
		--doc-dir=/usr/share/doc/${PF} \
		--menu-group="Game;Simulation;" \
		${myopts} \
		$(use_with iconv) \
		$(use_with png) \
		$(use_with lzo liblzo2) \
		|| die
}

src_compile() {
	emake VERBOSE=1 || die
}

src_test() {
	vecho ">>> Test phase [test]: ${CATEGORY}/${PF}"
	emake -j1 test || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	if use dedicated ; then
		newinitd "${FILESDIR}"/${PN}.initd ${PN}
		rm -rf "${D}"/usr/share/{applications,icons,pixmaps}
	fi
	rm -f "${D}"/usr/share/doc/${PF}/*
	dodoc readme.txt
	dodoc known-bugs.txt
	dodoc docs/admin_network.txt
	dodoc docs/multiplayer.txt
	doman docs/openttd.6

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	if ! use lzo ; then
		elog "OpenTTD was built without 'lzo' in USE. While 'lzo' is not"
		elog "required, disabling it does mean that loading old savegames"
		elog "or scenarios from ancient versions (~0.2) will fail."
		elog
	fi

	if use dedicated ; then
		ewarn "Warning: The init script will kill all running openttd"
		ewarn "processes when triggered, including any running client sessions!"
	else
		if use aplaymidi ; then
			elog "You have emerged with 'aplaymidi' for playing MIDI."
			elog "This option is for those with a hardware midi device,"
			elog "or who have set up ALSA to handle midi ports."
			elog "You must set the environment variable ALSA_OUTPUT_PORTS."
			elog "Available ports can be listed by using 'aplaymidi -l'."
		else
			if ! use timidity ; then
				elog "OpenTTD was built with neither 'aplaymidi' nor 'timidity'"
				elog "in USE. Music may or may not work in-game. If you happen"
				elog "to have timidity++ installed, music will work so long"
				elog "as it remains installed, but OpenTTD will not depend on it."
			fi
		fi
		if ! use openmedia ; then
			elog
			elog "OpenTTD was compiled without the 'openmedia' USE flag."
			elog
			elog "In order to play, you must at least install:"
			elog "games-misc/opengfx, and games-misc/opensfx, or copy the "
			elog "following 6 files from a version of Transport Tycoon Deluxe"
			elog "(windows or DOS) to ~/.openttd/data/ or"
			elog "${GAMES_DATADIR}/${PN}/data/."
			elog
			elog "From the WINDOWS version you need: "
			elog "sample.cat trg1r.grf trgcr.grf trghr.grf trgir.grf trgtr.grf"
			elog "OR from the DOS version you need: "
			elog "SAMPLE.CAT TRG1.GRF TRGC.GRF TRGH.GRF TRGI.GRF TRGT.GRF"
			elog
			elog "File names are case sensitive, but should work either with"
			elog "all upper or all lower case names"
			elog
			elog "In addition, in-game music will be unavailable: for music,"
			elog "install games-misc/openmsx, or use the in-game download"
			elog "functionality to get a music set"
			elog
		fi
	fi
}
