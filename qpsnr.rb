require "formula"

class qpsnr < Formula
  homepage "https://github.com/MarcAntoine-Arnaud/qpsnr"
  url "https://github.com/MarcAntoine-Arnaud/qpsnr.git", :branch => "master"
  version "master"

  devel do
    url "https://github.com/MarcAntoine-Arnaud/qpsnr.git", :branch => "develop"
    version "develop"
  end

  depends_on "scons" => :build
  depends_on "swig" => [:build, :recommended]  # python binding
  depends_on "ffmpeg"
  def install
    system "scons", "--install-sandbox=#{prefix}", "install"
  end
end
