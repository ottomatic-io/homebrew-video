require "formula"

class Tuttleofx < Formula
  homepage "http://www.tuttleofx.org"
  url "https://github.com/tuttleofx/TuttleOFX.git", :branch => "develop"
  # We currently use the develop version, the v0.9 will be the next release officially supporting homebrew.
  # :tag => "v0.9"
  version "0.9.0-dev"

  devel do
    url "https://github.com/tuttleofx/TuttleOFX.git", :branch => "develop"
    version "develop"
  end

  depends_on :python
  depends_on :x11
  depends_on "cmake" => :build
  depends_on "swig" => :build
  depends_on "boost" => "with-python"
  depends_on "ctl"
  depends_on "ffmpeg"
  depends_on "fontconfig"
  depends_on "freeglut"
  depends_on "freetype"
  depends_on "glew"
  depends_on "imagemagick"
  depends_on "jpeg"
  depends_on "jpeg-turbo"
  depends_on "libcaca"
  depends_on "libraw"
  depends_on "little-cms2"
  depends_on "openexr"
  depends_on "openjpeg"
  depends_on "seexpr"
  depends_on "homebrew/python/numpy"
  depends_on "homebrew/science/openimageio"

  def install
    system "./configure", "-DCMAKE_INSTALL_PREFIX=#{prefix}", "-DCMAKE_BUILD_TYPE=RELEASE"
    system "make", "install"
  end

  def test
    system "sam", "do", "-n"
  end
end
