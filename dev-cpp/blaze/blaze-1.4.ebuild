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

RDEPEND="blas? ( virtual/blas )
	mpi? ( virtual/mpi )
	>=dev-libs/boost-1.39"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_configure() {
	echo 'VERSION="release"' > GentooConfig
	echo "CXX=$(tc-getCXX)" >> GentooConfig
	echo 'LIBRARY_DIRECTIVES="-Wl,-soname,libblaze.so.0"' >> GentooConfig
	usex static-libs 'LIBRARY="both"' 'LIBRARY="shared"' >> GentooConfig
	usex blas 'BLAS="yes"' 'BLAS="no"' >> GentooConfig
	usex mpi 'MPI="yes"' 'MPI="no"' >> GentooConfig

	./configure GentooConfig || die
}

src_compile() {
	default
	use doc && doxygen
}

src_test() {
	pushd blazetest
	echo "CXX=$(tc-getCXX)" > GentooConfig
	usex blas 'BLAS="yes"' 'BLAS="no"' >> GentooConfig
	./configure GentooConfig || die
	emake
	./run || die
	popd
}

src_install() {
	dolib.so lib/libblaze.so
	dosym libblaze.so /usr/lib/libblaze.so.0
	use static-libs && dolib.a lib/libblaze.a
}
