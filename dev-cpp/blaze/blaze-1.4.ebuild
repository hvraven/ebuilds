# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="High-performance C++ math library for dense and sparse arithmetic"
HOMEPAGE="https://code.google.com/p/blaze-lib/"
SRC_URI="http://blaze-lib.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="blas doc mpi static-libs"

RDEPEND="blas? ( virtual/cblas )
	mpi? ( virtual/mpi[cxx] )
	>=dev-libs/boost-1.39"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

add_config() {
	echo $@ >> GentooConfig
}

my_usex() {
	usex $1 $2 $2 $3 $4 >> GentooConfig
}

src_configure() {
	add_config 'VERSION="release"'
	add_config "CXX=$(tc-getCXX)"
	EXTRA_LDFLAGS="-Wl,-soname,libblaze.so"
	my_usex static-libs LIBRARY= both shared
	if use blas ; then
		add_config 'BLAS=yes'
		add_config 'BLAS_INCLUDE_FILE=cblas.h'
	else
		add_config 'BLAS=no'
	fi
	if use mpi ; then
		add_config 'MPI=yes'
		EXTRA_LDFLAGS="${EXTRA_LDFLAGS} $(mpic++ --showme:link)"
	else
		add_config 'MPI=no'
	fi
	add_config "LIBRARY_DIRECTIVES=\"${EXTRA_LDFLAGS}\""

	./configure GentooConfig || die
}

src_compile() {
	default
	use doc && (doxygen || die)
}

src_test() {
	pushd blazetest
	./configure ../GentooConfig || die
	emake
	LD_LIBRARY_PATH="${S}/lib" ./run || die
	popd
}

src_install() {
	dolib.so lib/libblaze.so
	use static-libs && dolib.a lib/libblaze.a
	insinto /usr/include
	doins -r blaze

	use doc && dodoc -r doc/*
}
