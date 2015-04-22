require "formula"

class Avtranscoder < Formula
  homepage "https://github.com/avTranscoder/avTranscoder"
  url "https://github.com/avTranscoder/avTranscoder.git", :branch => "master"
  version "master"

  devel do
    url "https://github.com/avTranscoder/avTranscoder.git", :branch => "develop"
    version "develop"
  end

  depends_on "cmake" => :build
  depends_on "swig" => [:build, :recommended]  # python and java bindings
  depends_on "ffmpeg"
  depends_on "freeglut" => :optional  # for avplay app (need XQuartz, https://xquartz.macosforge.org)

  def install
    system "cmake", "-DCMAKE_INSTALL_PREFIX=#{prefix}", "-DCMAKE_BUILD_TYPE=RELEASE"
    system "make", "install"
  end
end
