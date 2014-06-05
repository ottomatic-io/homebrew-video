require "formula"

class Tuttleofx < Formula
  homepage "https://sites.google.com/site/tuttleofx/"
  url "https://github.com/tuttleofx/TuttleOFX.git", :branch => "develop"
  # We currently use the develop version, the v0.9 will be the next release officially supporting homebrew.
  # :tag => "v0.9"
  version "0.9.0-dev"

  devel do
    url "https://github.com/tuttleofx/TuttleOFX.git", :branch => "develop"
    version "develop"
  end

  depends_on :x11
  depends_on :python
  depends_on "homebrew/python/numpy"
  depends_on "scons" => :build
  depends_on "swig" => :build
  depends_on "boost" => "with-python"
  depends_on "jpeg"
  depends_on "openexr"
  depends_on "ffmpeg"
  depends_on "imagemagick"
  depends_on "openjpeg"
  depends_on "libcaca"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "freeglut"
  depends_on "glew"
  depends_on "little-cms2"
  depends_on "homebrew/science/openimageio"
  depends_on "jpeg-turbo"
  depends_on "libraw"
  depends_on "ctl"
  depends_on "seexpr"

  def install
    system "cp tools/sconf/macos_homebrew.sconf host.sconf"

    python_version = `python-config --libs`.match('-lpython(\d+\.\d+)').captures.at(0)
    puts "python_version #{python_version}"

    numpy = Formula["numpy"].prefix
    incdir_python_numpy="#{numpy}/lib/python#{python_version}/site-packages/numpy/core/include"
    puts "incdir_python_numpy #{incdir_python_numpy}"

    freetype = Formula["freetype"].prefix
    incdir_freetype = "#{freetype}/include/freetype2"
    puts "incdir_freetype #{incdir_freetype}"

    args = %W[
      INSTALLPATH=#{Dir.pwd}/install
      install=1
      -j #{ENV.make_jobs}
      incdir_python_numpy=#{incdir_python_numpy}
      incdir_freetype=#{incdir_freetype}
    ]

    scons *args

    prefix.install Dir["install/*"]
  end

  def caveats
    <<-EOS.undent
      You need to set the path to TuttleOFX plugins by:
        export OFX_PLUGIN_PATH=#{prefix}/plugin
    EOS
  end

  def test
    ENV.prepend_create_path "OFX_PLUGIN_PATH",  "#{prefix}/plugin"
    ENV.prepend_path "PATH", ENV["OFX_PLUGIN_PATH"]
    system "sam", "do", "-n"
  end
end
