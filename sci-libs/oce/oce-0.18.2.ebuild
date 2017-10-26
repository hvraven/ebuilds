# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils toolchain-funcs

DESCRIPTION="Opencascade community edition"
HOMEPAGE="https://github.com/tpaviot/oce"
SRC_URI="https://github.com/tpaviot/oce/archive/OCE-${PV}.tar.gz"

LICENSE="|| ( Open-CASCADE-LGPL-2.1-Exception-1.0 LGPL-2.1 )"
SLOT="0/0.18"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc freeimage gl2ps openmp tbb test vtk +X"
REQUIRED_USE="?? ( tbb openmp )"

DEPEND="dev-lang/tcl:0=
	dev-lang/tk:0=
	dev-tcltk/itcl
	dev-tcltk/itk
	dev-tcltk/tix
	media-libs/ftgl
	virtual/glu
	virtual/opengl
	x11-libs/libXmu
	freeimage? ( media-libs/freeimage )
	gl2ps? ( x11-libs/gl2ps )
	tbb? ( dev-cpp/tbb )
	vtk? ( sci-libs/vtk[rendering] sci-libs/vtk[all-modules] ) "
RDEPEND="${DEPEND}"

S="${WORKDIR}/oce-OCE-${PV}"

pkg_pretend() {
	use openmp && tc-check-openmp
}

pkg_setup() {
	use openmp && tc-check-openmp
}

src_configure() {
	local mycmakeargs=(
		-DOCE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DOCE_BUILD_SHARED_LIB=ON
		-DOCE_DATAEXCHANGE=ON
		-DOCE_WITH_FREEIMAGE=$(usex freeimage)
		-DOCE_WITH_GL2PS=$(usex gl2ps)
		-DOCE_WITH_VTK=$(usex vtk)
		-DOCE_ENABLE_DEB_FLAG=$(usex debug)
		-DOCE_DISABLE_X11=$(usex X no yes)
		-DOCE_TESTING=$(usex test)
		-DOCE_USE_TCL_TEST_FRAMEWORK=$(usex test)
	)
	use openmp && mycmakeargs+=( -DOCE_MULTITHREAD_LIBRARY=OPENMP )
	use tbb && mycmakeargs+=( -DOCE_MULTITHREAD_LIBRARY=TBB )

	cmake-utils_src_configure
}
