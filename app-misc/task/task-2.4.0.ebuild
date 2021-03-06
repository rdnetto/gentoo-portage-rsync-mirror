# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/task/task-2.4.0.ebuild,v 1.1 2015/02/11 01:30:47 radhermit Exp $

EAPI=5

inherit eutils cmake-utils bash-completion-r1

DESCRIPTION="Taskwarrior is a command-line todo list manager"
HOMEPAGE="http://taskwarrior.org/"
SRC_URI="http://taskwarrior.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~x64-macos"
IUSE="gnutls vim-syntax zsh-completion"

DEPEND="sys-libs/readline
	gnutls? ( net-libs/gnutls )
	elibc_glibc? ( sys-apps/util-linux )"
RDEPEND="${DEPEND}"

src_prepare() {
	# use the correct directory locations
	sed -i "s:/usr/local/bin:${EPREFIX}/usr/bin:" \
		scripts/add-ons/* || die

	# don't automatically install scripts
	sed -i '/scripts/d' CMakeLists.txt || die

	epatch "${FILESDIR}"/${PN}-2.3.0-gnutls-automagic.patch
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_use gnutls GNUTLS)
		-DTASK_DOCDIR=share/doc/${PF}
		-DTASK_RCDIR=share/${PN}/rc
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	newbashcomp scripts/bash/task.sh task

	if use vim-syntax ; then
		rm scripts/vim/README
		insinto /usr/share/vim/vimfiles
		doins -r scripts/vim/*
	fi

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins scripts/zsh/*
	fi

	exeinto /usr/share/${PN}/scripts
	doexe scripts/add-ons/*
}
