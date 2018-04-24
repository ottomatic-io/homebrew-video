require "formula"

class Libmxfpp < Formula
  homepage "http://sourceforge.net/p/bmxlib/home/Home/"
  url "https://downloads.sourceforge.net/project/bmxlib/bmx-snapshot-20150603/bmx-snapshot-20150603.tar.gz"
  sha256 "89ee63ce06a2e0e3d512bbd0cf9b37b9c8b3bc1e4b3685e14d6bfddd29527d30"

  depends_on "pkg-config" => :build
  depends_on "libtool" => :build
  depends_on "libmxf"

  def install
    Dir.chdir "libmxf++"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
