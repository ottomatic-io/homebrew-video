class Libmxfpp < Formula
  desc "C++ wrapper library for libMXF (MXF file format)"
  homepage "https://github.com/ebu/bmx"
  # libMXF++ is no longer released standalone (BBC's repo is archived at v1.1).
  # Its maintained source ships inside the bmx release under deps/libMXFpp, so
  # this formula builds that subdirectory. Keep url + sha256 in lockstep with
  # the bmx and libmxf formulas.
  url "https://github.com/ebu/bmx/releases/download/v1.7/bmx-1.7.tar.gz"
  sha256 "448242a31c77517a472eab8aa05bbe98d6c50814d7990d17696444c0564bfb34"

  depends_on "cmake" => :build
  depends_on "libmxf"

  def install
    # LIBMXFPP_BUILD_LIBMXF_LIB=ON links the external libmxf formula via
    # pkg-config instead of the bundled deps/libMXF copy.
    # CMAKE_POLICY_VERSION_MINIMUM: deps/cmake-git-version-tracking needs the
    # pre-4 policy. CMAKE_INSTALL_RPATH lets the tools find libMXF++ in this keg.
    # Empty CMAKE_PROJECT_TOP_LEVEL_INCLUDES overrides Homebrew's FetchContent
    # trap, which otherwise blocks the (network-free, bundled) git-version dep.
    system "cmake", "-S", "deps/libMXFpp", "-B", "build",
           "-DCMAKE_POLICY_VERSION_MINIMUM=3.5",
           "-DLIBMXFPP_BUILD_LIBMXF_LIB=ON",
           "-DCMAKE_INSTALL_RPATH=#{rpath}",
           *std_cmake_args,
           "-DCMAKE_PROJECT_TOP_LEVEL_INCLUDES="
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
