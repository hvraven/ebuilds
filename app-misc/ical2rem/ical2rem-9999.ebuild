# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"
RUBY_FAKEGEM_NAME="ical2rem.rb"
inherit ruby-fakegem git-2

DESCRIPTION="Converter from iCal to the reminder file format"
HOMEPAGE="https://github.com/courts/ical2rem.rb"
SRC_URI="" # explicitly empty to overwrite the automatic gem path
EGIT_REPO_URI="https://github.com/courts/ical2rem.rb.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
ruby_add_rdepend "dev-ruby/rical"

EGIT_SOURCEDIR="${S}/all"
