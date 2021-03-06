# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-SCRAM/Authen-SCRAM-0.5.0.ebuild,v 1.1 2015/02/21 21:34:31 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=0.005
inherit perl-module

DESCRIPTION="Salted Challenge Response Authentication Mechanism (RFC 5802)"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/Authen-SASL-SASLprep
	virtual/perl-Carp
	dev-perl/Crypt-URandom
	virtual/perl-Encode
	virtual/perl-MIME-Base64
	>=dev-perl/Moo-1.1.0
	>=dev-perl/PBKDF2-Tiny-0.3.0
	dev-perl/Try-Tiny
	dev-perl/Type-Tiny
	dev-perl/namespace-clean
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.170.0
	test? (
		virtual/perl-Exporter
		virtual/perl-File-Spec
		dev-perl/Test-FailWarnings
		dev-perl/Test-Fatal
		>=virtual/perl-Test-Simple-0.960.0
	)
"
