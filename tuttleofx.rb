require 'formula'

class Tuttleofx < Formula
  homepage 'https://sites.google.com/site/tuttleofx/'
  url 'https://github.com/tuttleofx/TuttleOFX.git', :tag => 'v0.7.0'

  devel do
    url 'https://github.com/tuttleofx/TuttleOFX.git', :branch => 'develop'
    version 'develop'
  end

  depends_on :x11
  depends_on :python
  depends_on 'scons' => :build
  depends_on 'swig' => :build
  depends_on 'boost'
  depends_on 'jpeg'
  depends_on 'openexr'
  depends_on 'ffmpeg'
  depends_on 'imagemagick'
  depends_on 'openjpeg'
  depends_on 'libcaca'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'freeglut'
  depends_on 'glew'
  depends_on 'little-cms2'
  depends_on 'homebrew/science/openimageio'
  depends_on 'jpeg-turbo'
  depends_on 'libraw'
  depends_on 'ctl'

  def install
    system "cp tools/sconf/macos_homebrew.sconf host.sconf"
    system "scons -k"
    system "mv dist/`hostname`/gcc-`gcc -dumpversion`/production/ install"
    prefix.install Dir['install/*']
  end

  def caveats
    <<-EOS.undent
      You need to set OFX_PLUGIN_PATH and PATH by:
        export OFX_PLUGIN_PATH=#{prefix}/plugin && export PATH=$OFX_PLUGIN_PATH/bin:$PATH
    EOS
  end

  def test
    system "export OFX_PLUGIN_PATH=#{prefix}/plugin && export PATH=$OFX_PLUGIN_PATH/bin:$PATH"
    system "sam"
  end
end
