# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Written by Takeshi KIRIYA (aka takeshik) <me@takeshik.org>.

inherit flag-o-matic apache-module

DESCRIPTION="A file upload application works as Apache module"
HOMEPAGE="http://acapulco.dyndns.org/mod_uploader/"
SRC_URI="http://sourceforge.jp/frs/redir.php?f=%2Fmod-uploader%2F37519%2F${P}.tgz"
RESTRICT=nomirror

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="imagemagick empty-comment empty-password remove-unpopular"

DEPEND="imagemagick? ( media-gfx/imagemagick )"
RDEPEND="${DEPEND}"

need_apache2

src_compile() {
	local confargs
	confargs="--with-march=native"
	[ ${NUMNAME} != "" ] && confargs="${CONFARGS} --with-numname=${NUMNAME}"
	use imagemagick && confargs="${CONFARGS} --enable-thumbnail --with-mconf=/usr"
	use empty-comment && confargs="${CONFARGS} --enable-empty-comment"
	use empty-password && confargs="${CONFARGS} --enable-empty-comment"
	use remove-unpopular && confargs="${CONFARGS} --enable-remove-unpopular"
	
	econf ${confargs} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	apache-module_src_install
	dodoc AUTHORS COPYING ChangeLog MEMO css/* img/* js/* swf/* tmpl/*
}

pkg_postinst() {
	einfo "Sorry but you should configure mod_uploader by hand."
	einfo "Documents and page resources are in /usr/share/doc/${P}/"
}