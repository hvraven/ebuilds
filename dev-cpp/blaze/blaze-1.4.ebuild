# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit flag-o-matic toolchain-funcs

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

my_addconfig() {
	echo $@ >> GentooConfig
}

my_usex() {
	my_addconfig $(usex $1 $2 $2 $3 $4)
}

src_configure() {
	my_addconfig 'VERSION="release"'
	my_addconfig "CXX=$(tc-getCXX)"
	append-ldflags -Wl,-soname,libblaze.so

	my_usex static-libs LIBRARY= both shared

	if use blas ; then
		my_addconfig 'BLAS=yes'
		my_addconfig 'BLAS_INCLUDE_FILE=cblas.h'
	else
		my_addconfig 'BLAS=no'
	fi

	if use mpi ; then
		my_addconfig 'MPI=yes'
		append-cxxflags $(mpicxx --showme:compile)
		append-cppflags $(mpicxx --showme:incdirs)
		append-libs $(mpicxx --showme:libs)
	else
		my_addconfig 'MPI=no'
	fi

	my_addconfig "LIBRARY_DIRECTIVES=\"$LDFLAGS $LIBS\""

	./configure GentooConfig || die

	# verbose building
	sed -i Makefile */*/Makefile \
		-e 's/^\t@/\t/' -e 's/^\techo/\t@echo/' || die

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
