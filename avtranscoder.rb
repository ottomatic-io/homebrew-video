require "formula"

class Avtranscoder < Formula
  homepage ""
  url "https://github.com/mikrosimage/avTranscoder.git", :branch => "release/v0.4.3"
  version "0.4.3"
  # Currently Mikros Image fork of the official repository (https://github.com/avTranscoder/avTranscoder).

  depends_on "cmake" => :build
  depends_on "swig" => :recommended  # python and java bindings
  depends_on "ffmpeg"
  depends_on "freeglut" => :optional  # for avplay app (need XQuartz, https://xquartz.macosforge.org)

  def install
    system "cmake", "-DCMAKE_INSTALL_PREFIX=#{prefix}", "-DCMAKE_BUILD_TYPE=RELEASE"
    system "make", "install"
  end
end
