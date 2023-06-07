require "formula"

class Bmx < Formula
  homepage "https://github.com/bbc/bmx"
  url "https://github.com/bbc/bmx/releases/download/v1.1/bmx-1.1.tar.gz"
  sha256 "6d4a32a78af9da64b345bb7ed42375e1d9aa4d89263f3334cc5cfd5173e3b645"

  depends_on "cmake" => :build
  depends_on "expat"
  depends_on "uriparser"
  depends_on "libmxf"
  depends_on "libmxfpp"

  def install
    system "cmake", "-S", ".", "-B", "build", "-DBMX_BUILD_LIBMXF_LIB=ON", "-DBMX_BUILD_LIBMXFPP_LIB=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
