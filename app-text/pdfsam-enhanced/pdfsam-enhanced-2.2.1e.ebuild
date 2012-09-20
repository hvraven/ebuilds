# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit java-pkg-2 java-ant-2

DESCRIPTION="A tool to split and merge pdf documents"
HOMEPAGE="http://www.pdfsam.org"
SRC_URI="mirror://sourceforge/project/pdfsam/${PN}/${PV}/pdfsam-${PV}-out-src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=virtual/jdk-1.5
	dev-java/ant-core
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}"

src_unpack() {
	unpack "${A}"
	unpack ./*.zip
}

src_prepare() {
	sed -i 's/\/media\/LACIE\/pdfsam\/workspace-enhanced/\.\./' \
		*/ant/build.properties || die
	sed -i 's/\/media\/LACIE\/build-2/\.\./' */ant/build.properties || die
	sed -i s'/\/media\/LACIE\/build/\.\./' */ant/build.properties || die
}

src_compile() {
	eant ${antflags} -buildfile pdfsam-maine/ant/build.xml || die
}

src_install() {
	cd pdfsam-maine/release/dist/pdfsam-enhanced
   	java-pkg_jarinto /usr/share/${PN}
	java-pkg_newjar pdfsam-${PV}.jar
	java-pkg_newjar lib/pdfsam-console-2.3.1e.jar pdfsam-console.jar

   	java-pkg_jarinto /usr/share/${PN}/lib
	java-pkg_dojar lib/*.jar

	insinto /usr/share/${PN}/lib
	doins pdfsam-config.xml

	for plugin in $(ls -1 plugins) ; do
    	java-pkg_jarinto /usr/share/${PN}/plugins/${plugin}
	    java-pkg_dojar plugins/${plugin}/*.jar
	    insinto /usr/share/${PN}/plugins/${plugin}
	    doins plugins/${plugin}/config.xml
	done

	java-pkg_dolauncher ${PN} --main org.pdfsam.guiclient.GuiClient \
		--pwd "/usr/share/${PN}"
	java-pkg_dolauncher ${PN}-console --main org.pdfsam.console.ConsoleClient \
		--pwd "/usr/share/${PN}"

	newicon ../../../images/pdf.png ${PN}.png
	make_desktop_entry "${PN}" "PDF Split and Merge" ${PN} Office
}
