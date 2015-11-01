require "formula"

class Tuttleofx < Formula
  homepage "http://www.tuttleofx.org"
  url "https://github.com/tuttleofx/TuttleOFX.git", :tag => "v0.12.1"
  version "0.12.1"

  devel do
    url "https://github.com/tuttleofx/TuttleOFX.git", :branch => "develop"
    version "develop"
  end
  
  bottle do
    root_url "https://bintray.com/artifact/download/cbenhagen/homebrew-video"
    sha256 "0f06bab20cee751094bdea2ea46927a8c4f28e17759f995d5dc9187d25da4506" => :yosemite
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
  depends_on "homebrew/python/numpy" => :recommended
  depends_on "homebrew/science/openimageio"
  depends_on "homebrew/x11/freeglut"

  # for sam tools
  if build.with?("python")
    depends_on "clint" => :python
    depends_on "argcomplete" => :python
  end

  if build.with?("python3")
    depends_on "clint" => :python3
    depends_on "argcomplete" => :python3
  end

  if build.without?("python3") && build.without?("python")
    odie "tuttleofx: --with-python3 must be specified when using --without-python"
  end

  def install
    Language::Python.each_python(build) do |python, version|
      py_abspath = `#{python} -c "import sys; print(sys.executable)"`.strip
      py_prefix = `#{python} -c "from __future__ import print_function; import sys; print(sys.prefix)"`.strip
      py_include = `#{python} -c "from __future__ import print_function; import distutils.sysconfig; print(distutils.sysconfig.get_python_inc(True))"`.strip
      py_numpy = build.without?("numpy")

      mkdir_p "build_py#{version}"
      cd "build_py#{version}"
      system "cmake", "..",
                   "-DCMAKE_INSTALL_PREFIX=#{prefix}",
                   "-DCMAKE_BUILD_TYPE=RELEASE",
                   "-DPYTHON_EXECUTABLE=#{py_abspath}",
                   "-DPYTHON_LIBRARY=#{py_prefix}/lib/libpython#{version}.dylib",
                   "-DPYTHON_INCLUDE_DIR=#{py_include}",
                   "-DWITHOUT_NUMPY=#{py_numpy}"

      system "make"
      system "make", "install"
      cd ".."
    end
  end

  test do
    system "sam", "do", "-n"
  end

  def caveats; <<-EOS.undent
    Before using TuttleOFX plugins, you need to set an environment variable to tell where are the plugins:
    export OFX_PLUGIN_PATH=/usr/local/Cellar/tuttleofx/#{version}/OFX

    For usage instructions:
        more #{opt_prefix}/USAGE.md
    EOS
  end

end
