# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-2 multilib

DESCRIPTION="Library for working with MIME messages and Internet messaging services like IMAP, POP or SMTP"
HOMEPAGE="http://www.vmime.org"
EGIT_REPO_URI="git://github.com/kisli/vmime"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc examples +gnutls +imap +maildir +pop sasl sendmail +smtp ssl static-libs"

RDEPEND="virtual/libiconv
	ssl? (
		gnutls? ( >=net-libs/gnutls-1.2.0 )
		!gnutls? ( dev-libs/openssl )
	)
	sasl? ( virtual/gsasl )
	sendmail? ( virtual/mta )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use sasl VMIME_HAVE_SASL_SUPPORT)
		$(cmake-utils_use ssl VMIME_HAVE_TLS_SUPPORT)
		$(cmake-utils_use pop VMIME_HAVE_MESSAGING_PROTO_POP3)
		$(cmake-utils_use smtp VMIME_HAVE_MESSAGING_PROTO_SMTP)
		$(cmake-utils_use imap VMIME_HAVE_MESSAGING_PROTO_IMAP)
		$(cmake-utils_use maildir VMIME_HAVE_MESSAGING_PROTO_MAILDIR)
		$(cmake-utils_use sendmail VMIME_HAVE_MESSAGING_PROTO_SENDMAIL)
		$(cmake-utils_use static-libs VMIME_BUILD_STATIC_LIBRARY)
		$(cmake-utils_use gnutls VMIME_TLS_SUPPORT_LIB_IS_GNUTLS)
		$(cmake-utils_use !gnutls VMIME_TLS_SUPPORT_LIB_IS_OPENSSL)
		-DVMIME_INSTALL_LIBDIR=$(get_libdir)
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	if use doc ; then
		cmake-utils_src_compile doc
	fi
}

src_install() {
	cmake-utils_src_install
	dodoc HACKING NEWS README

	if use doc ; then
		dodoc -r "${BUILD_DIR}/doc"
	fi
}
