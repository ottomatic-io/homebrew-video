require 'formula'

class Tuttleofx < Formula
  homepage 'https://sites.google.com/site/tuttleofx/'
  url 'https://github.com/tuttleofx/TuttleOFX.git', :tag => 'v0.7.0'
  version '0.7.0'

  devel do
    url 'https://github.com/tuttleofx/TuttleOFX.git', :branch => 'develop'
  end

  depends_on :x11
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
  depends_on 'openimageio'
  depends_on 'jpeg-turbo'
  depends_on 'libraw'
  depends_on 'ctl'

  def patches
    # use gl
    DATA
  end

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
__END__
diff --git a/tools/sconsProject/autoconf/gl.py b/tools/sconsProject/autoconf/gl.py
index 59da2a6..4294c4f 100755
--- a/tools/sconsProject/autoconf/gl.py
+++ b/tools/sconsProject/autoconf/gl.py
@@ -2,8 +2,6 @@ from _external import *
 
 if windows:
     gl = LibWithHeaderChecker('opengl32', ['windows.h','GL/gl.h'], 'c', name='gl')
-elif macos:
-    gl = LibWithHeaderChecker('OpenGL', ['AGL/gl.h'], 'c', name='gl')
 else : # unix
     gl = LibWithHeaderChecker('GL', ['GL/gl.h'], 'c', name='gl')
