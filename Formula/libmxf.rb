require "formula"

class Libmxf < Formula
  homepage "https://github.com/bbc/libMXF"
  url "https://github.com/bbc/libMXF/archive/refs/tags/v1.1.tar.gz"
  sha256 "7257db76790de2a9ba36dbe900c6ea062d61c8b419b80c1adafb915c6b181e02"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
