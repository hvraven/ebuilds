# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
#!/bin/bash

EAPI=5

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Git extension for versioning large files"
HOMEPAGE="https://git-lfs.github.com/"
SRC_URI="https://github.com/github/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-text/ronn"
RDEPEND=""

EGO_PN="github.com/github/git-lfs"

src_compile() {
	golang-build_src_compile
	ronn -r src/github.com/github/git-lfs/docs/man/*.ronn || die
}

src_install() {
	default

	dobin git-lfs
	doman src/github.com/github/git-lfs/docs/man/*.1

	golang-build_src_install
}
