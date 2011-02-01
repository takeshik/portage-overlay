# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Written by Takeshi KIRIYA (aka takeshik) <me@takeshik.org>.

inherit flag-o-matic

DESCRIPTION="DHCP Client and Server originally developed by KAME Project"
HOMEPAGE="http://wide-dhcpv6.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/project/wide-dhcpv6/wide-dhcpv6/wide-dhcpv6-20080615/wide-dhcpv6-20080615.tar.gz"
RESTRICT=nomirror

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	econf || die "econf failed"
	epatch "${FILESDIR}/fix-libc-depend.patch"
	epatch "${FILESDIR}/fix-dprintf-conflict.patch"
	epatch "${FILESDIR}/address-suffix-1.patch"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
}
