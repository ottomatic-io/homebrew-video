require "formula"

class Libmxf < Formula
  homepage "http://sourceforge.net/p/bmxlib/home/Home/"
  url "https://downloads.sourceforge.net/project/bmxlib/bmx-snapshot-20170814/bmx-snapshot-20170814.tar.gz"
  sha256 "2c86a106a7abf56822b3dbfa9a680ca65a64529e466b80e2bd34ac4805db524f"

  # does not build with superenv
  env :std

  depends_on "pkg-config" => :build
  depends_on "libtool" => :build

  def install
    Dir.chdir "libmxf"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-examples",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
