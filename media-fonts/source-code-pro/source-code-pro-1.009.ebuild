# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit font

DESCRIPTION="A Adobe font desigend for UI environments with clear differences
between similar symbols."
HOMEPAGE="https://github.com/adobe/Source-Code-Pro"
SRC_URI="https://github.com/downloads/adobe/Source-Code-Pro/SourceCodePro_FontsOnly-${PV}.zip"

LICENSE="OFL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/SourceCodePro_FontsOnly-${PV}"
FONT_SUFFIX="ttf otf"
