# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils flag-o-matic qmake-utils

DESCRIPTION="Media manager for movies, series and concerts"
HOMEPAGE="http://www.mediaelch.de"
SRC_URI="http://www.kvibes.de/releases/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/libmediainfo
	dev-libs/quazip[qt5(+)]
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5[widgets]
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtnetwork:5
	dev-qt/qtopengl:5
	dev-qt/qtscript:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5"
RDEPEND="${DEPEND}"

src_prepare() {
	# remove references to bundled quazip
	sed -i */*.cpp \
		-e 's:#include "quazip/quazip\(.*\)":#include <quazip5\1>:' || die
	sed -i MediaElch.pro \
		-e 's:include(quazip/quazip/quazip.pri):LIBS += -lquazip5:' || die

	default
}

src_configure() {
	append-cxxflags -std=c++11

	eqmake5
}

src_install() {
	dobin MediaElch
	doicon desktop/MediaElch.png
	make_desktop_entry MediaElch MediaElch MediaElch
}
