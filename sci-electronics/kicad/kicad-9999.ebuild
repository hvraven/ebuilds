# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

WX_GTK_VER="3.0"

inherit cmake-utils eutils flag-o-matic git-r3 gnome2-utils python-single-r1 wxwidgets xdg

DESCRIPTION="Electronic Schematic and PCB design tools."
HOMEPAGE="http://www.kicad-pcb.org"
EGIT_REPO_URI="https://git.launchpad.net/kicad"

LICENSE="GPL-2+ GPL-3+ Boost-1.0"
SLOT="0"
KEYWORDS=""
IUSE="debug doc examples +github +python spice step"
LANGS="bg ca cs de el es fi fr hu it ja ko nl pl pt ru sk sl sv zh-CN"
for lang in ${LANGS} ; do
	IUSE="${IUSE} l10n_${lang}"
done
unset lang

REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )"

COMMON_DEPEND=">=x11-libs/wxGTK-3.0.2:${WX_GTK_VER}[X,opengl]
	python? (
		dev-python/wxpython:${WX_GTK_VER}[opengl,${PYTHON_USEDEP}]
		${PYTHON_DEPS}
	)
	>=dev-libs/boost-1.61[context,nls,threads,python?,${PYTHON_USEDEP}]
	github? ( net-misc/curl[ssl] )
	media-libs/glew:0=
	media-libs/glm
	media-libs/freeglut
	media-libs/mesa
	spice? ( sci-electronics/ngspice )
	step? ( sci-libs/oce:= )
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/pixman"
DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )
	python? ( >=dev-lang/swig-3.0 )"
RDEPEND="${COMMON_DEPEND}
	sci-electronics/electronics-menu"

pkg_setup() {
	use python && python-single-r1_pkg_setup
	setup-wxwidgets
}

src_prepare() {
	xdg_src_prepare

	# remove all the non unix file endings and fix application categories in desktop files
	while IFS="" read -d $'\0' -r f; do
		edos2unix "${f}"
		sed -i '/Categories/s/Development;//' "${f}"
	done < <(find "${S}" -type f -name "*.desktop" -print0)
}

src_configure() {
	local mycmakeargs=(
		-DKICAD_DOCS="/usr/share/doc/${PF}"
		-DBUILD_GITHUB_PLUGIN="$(usex github)"
		-DKICAD_SCRIPTING="$(usex python)"
		-DKICAD_SCRIPTING_MODULES="$(usex python)"
		-DKICAD_SCRIPTING_WXPYTHON="$(usex python)"
		-DKICAD_SCRIPTING_ACTION_MENU="$(usex python)"
		-DKICAD_USE_OCE="$(usex step)"
		-DKICAD_SPICE="$(usex spice)"
		-DKICAD_INSTALL_DEMOS="$(usex examples)"
	)
	use python && mycmakeargs+=(
		-DPYTHON_DEST="$(python_get_sitedir)"
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DPYTHON_INCLUDE_DIR="$(python_get_includedir)"
		-DPYTHON_LIBRARY="$(python_get_library_path)"
	)
	if use debug; then
		append-cxxflags "-DDEBUG"
		append-cflags "-DDEBUG"
	fi
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	if use doc; then
		doxygen Doxyfile || die
	fi
}

src_install() {
	cmake-utils_src_install
	use python && python_optimize
	if use doc ; then
		dodoc uncrustify.cfg
		cd Documentation || die
		dodoc -r GUI_Translation_HOWTO.pdf guidelines/UIpolicies.txt doxygen/.
	fi
}

pkg_preinst() {
	xdg_pkg_preinst
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_icon_cache_update

	elog "You may want to emerge media-gfx/wings if you want to create 3D models of components."
	elog "For help and extended documentation emerge app-doc/kicad-doc."
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_icon_cache_update
}
