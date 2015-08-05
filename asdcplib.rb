require "formula"

class Asdcplib < Formula
  homepage "https://github.com/MarcAntoine-Arnaud/asdcplib"
  url "https://github.com/MarcAntoine-Arnaud/asdcplib.git", :branch => "master"
  version "master"

  devel do
    url "https://github.com/MarcAntoine-Arnaud/asdcplib.git", :branch => "develop"
    version "develop"
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--enable-as-02", "--enable-dev-headers"
    system "make", "install"
  end
end
