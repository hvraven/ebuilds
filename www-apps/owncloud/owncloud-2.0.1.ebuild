# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/owncloud/owncloud-1.2.ebuild,v 1.1 2011/04/27 12:10:20 alexxy Exp $

inherit webapp eutils depend.php

DESCRIPTION="Web-based storage application where all your data is under your own control"
HOMEPAGE="http://owncloud.org"
SRC_URI="http://owncloud.org/releases/${P}.tar.bz2"

LICENSE="AGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

need_httpd_cgi
need_php_httpd

S="${WORKDIR}/${PN}"

pkg_setup() {
	flags="json xmlwriter zip"
	webapp_pkg_setup || die
	has_php || die
	require_php_with_use ${flags}
}

src_install() {
	cd "${S}"
	webapp_src_preinst || die

	local docs="README"
	dodoc ${docs} || die
	rm -f ${docs}
	insinto "${MY_HTDOCSDIR}"
	doins -r * || die
	doins .htaccess || die
	dodir "${MY_HTDOCSDIR}"/data || die
	webapp_serverowned "${MY_HTDOCSDIR}"/data || die
	webapp_serverowned "${MY_HTDOCSDIR}"/config || die

	webapp_src_install || die
}
