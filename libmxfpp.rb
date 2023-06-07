require "formula"

class Libmxfpp < Formula
  homepage "https://github.com/bbc/libMXFpp"
  url "https://github.com/bbc/libMXFpp/archive/refs/tags/v1.1.tar.gz"
  sha256 "7ca29e8728ce3ed34d0b0ef4384641e8b0973fc7ac973ec6f12d41044d0ea44e"

  depends_on "cmake" => :build
  depends_on "libmxf"

  def install
    system "cmake", "-S", ".", "-B", "build", "-DLIBMXFPP_BUILD_LIBMXF_LIB=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
