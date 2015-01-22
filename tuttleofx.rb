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

  depends_on :python => :recommended
  depends_on :python3 => :optional
  depends_on :x11
  depends_on "cmake" => :build
  depends_on "swig" => :build
  depends_on "boost"
  depends_on "boost-python"
  depends_on "ctl"
  depends_on "ffmpeg"
  depends_on "fontconfig"
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
  depends_on "homebrew/x11/freeglut"

  if build.without?("python3") && build.without?("python")
    odie "tuttleofx: --with-python3 must be specified when using --without-python"
  end

  def install
    Language::Python.each_python(build) do |python, version|
      py_abspath = `#{python} -c "import sys; print(sys.executable)"`.strip
      py_prefix = `#{python} -c "from __future__ import print_function; import sys; print(sys.prefix)"`.strip
      py_include = `#{python} -c "from __future__ import print_function; import distutils.sysconfig; print(distutils.sysconfig.get_python_inc(True))"`.strip

      mkdir_p "build_py#{version}"
      cd "build_py#{version}"
      system "cmake", "..",
                   "-DCMAKE_INSTALL_PREFIX=#{prefix}",
                   "-DCMAKE_BUILD_TYPE=RELEASE",
                   "-DPYTHON_EXECUTABLE=#{py_abspath}",
                   "-DPYTHON_LIBRARY=#{py_prefix}/lib/libpython#{version}.dylib",
                   "-DPYTHON_INCLUDE_DIR=#{py_include}"

      system "make", "install"
      cd ".."
    end
  end

  def test
    system "sam", "do", "-n"
  end
end
