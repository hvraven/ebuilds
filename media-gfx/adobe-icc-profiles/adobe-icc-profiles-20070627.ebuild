# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Adobe ICC profiles for RGB and CMYK."
HOMEPAGE="http://www.adobe.com"
SRC_URI="http://download.adobe.com/pub/adobe/iccprofiles/win/AdobeICCProfilesWin_end-user.zip"

LICENSE="Adobe-ICC"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/Adobe ICC Profiles (end-user)"

src_install() {
	insinto /usr/share/color/icc/adobe
	doins RGB\ Profiles/*
	doins CMYK\ Profiles/*
}
