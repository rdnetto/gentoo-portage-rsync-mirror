# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pocl/pocl-0.11.ebuild,v 1.2 2015/03/17 15:34:46 patrick Exp $

EAPI=5

DESCRIPTION="PortableCL: opensource implementation of the OpenCL standard"
HOMEPAGE="http://portablecl.org/"
SRC_URI="http://portablecl.org/downloads/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/ocl-icd
	=sys-devel/llvm-3.6*
	sys-apps/hwloc"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_pretend() {
	# Needs an OpenCL 1.2 ICD, mesa and nvidia are invalid
	# Maybe ati works, feel free to add/fix if you can test
	if [[ $(eselect opencl show) == 'ocl-icd' ]]; then
		einfo "Valid OpenCL ICD set"
	else
		eerror "Please use a supported ICD:"
		eerror "eselect opencl set ocl-icd"
		die "OpenCL ICD not set to a supported value"
	fi
}
