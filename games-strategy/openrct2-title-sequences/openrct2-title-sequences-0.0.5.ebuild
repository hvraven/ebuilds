# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Title sequences used for OpenRCT2"
HOMEPAGE="https://github.com/OpenRCT2/title-sequences"
SRC_URI="https://github.com/OpenRCT2/title-sequences/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/p7zip"
RDEPEND=""

S="$WORKDIR/title-sequences-$PV"

src_prepare() {
	# move things around to include the latest build
	mv title/v${PV} title/openrct2 || die
	rm -r title/v* || die

	default
}

src_compile() {
	for dir in title/* ; do
		pushd $dir
			7z a -tzip -mx9 -mtc=off -r "$S/${dir##*/}.parkseq" * || die
		popd
	done
}

src_install() {
	insinto /usr/share/openrct2/title
	doins *.parkseq
}
