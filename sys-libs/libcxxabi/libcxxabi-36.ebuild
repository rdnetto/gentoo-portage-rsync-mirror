# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Source: https://nullfxp.googlecode.com/svn-history/r1122/vendor/portage/sys-libs/libcxxabi/libcxxabi-9999.ebuild

EAPI=4

DESCRIPTION="New implementation of the C++ ABI, targeting C++0X"
HOMEPAGE="http://libcxxabi.llvm.org/"

if [ "${PV%9999}" = "${PV}" ] ; then
	ESVN_REPO_URI="http://llvm.org/svn/llvm-project/libcxxabi/branches/release_${PV}"
else
	ESVN_REPO_URI="http://llvm.org/svn/llvm-project/libcxxabi/trunk"
fi

inherit subversion eutils cmake-utils

LICENSE="|| ( UoI-NCSA MIT )"
SLOT="0"
if [ "${PV%9999}" = "${PV}" ] ; then
        KEYWORDS="~amd64"
else
        KEYWORDS=""
fi
IUSE=""

RDEPEND="!sys-libs/libcxxrt"
DEPEND="${RDEPEND}
        sys-libs/libunwind
        sys-devel/clang"

src_prepare(){
	epatch "${FILESDIR}/fix-buildit.patch"
}

src_configure(){
	#need to reference a copy of the libcxx source, which hasn't been installed yet
	svn co -q http://llvm.org/svn/llvm-project/libcxx/branches/release_36 ${WORKDIR}/libcxx

	LIBCXXABI_LIBCXX_INCLUDES=${WORKDIR}/libcxx
	local mycmakeargs="-DLIBCXXABI_LIBCXX_INCLUDES=${LIBCXXABI_LIBCXX_INCLUDES} -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++"
	CC=clang
	CXX=clang++
	CXXFLAGS+=" -I${LIBCXXABI_LIBCXX_INCLUDES}/include"
	cmake-utils_src_configure
}

src_compile() {
        pushd "${S}"/lib
        ./buildit || die
        popd
}

src_install() {
        pushd "${S}"

        pushd lib
        dolib.so lib*.so* || die
        dosym libc++abi.so.1.0 ${DESTTREE}/$(get_libdir)/libc++abi.so.1
        dosym libc++abi.so.1 ${DESTTREE}/$(get_libdir)/libc++abi.so
        popd

		# Keep the headers from libunwind
		rm include/unwind.h
		rm include/libunwind.h

        insinto /usr/include
        doins include/*

        dodoc CREDITS.TXT

        popd
}
