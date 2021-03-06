# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-bugzilla/python-bugzilla-1.1.0.ebuild,v 1.2 2015/04/08 08:05:16 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_4 )

inherit distutils-r1

DESCRIPTION="A python module for interacting with Bugzilla over XMLRPC"
HOMEPAGE="https://fedorahosted.org/python-bugzilla/"
SRC_URI="https://fedorahosted.org/releases/p/y/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="GPL-2"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/python-magic
	dev-python/requests
"
