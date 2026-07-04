class Libmxf < Formula
  desc "Library for reading and writing the MXF file format"
  homepage "https://github.com/ebu/bmx"
  # libMXF is no longer released standalone (BBC's repo is archived at v1.1).
  # Its maintained source ships inside the bmx release under deps/libMXF, so
  # this formula builds that subdirectory. Keep url + sha256 in lockstep with
  # the bmx and libmxfpp formulas.
  url "https://github.com/ebu/bmx/releases/download/v1.7/bmx-1.7.tar.gz"
  sha256 "448242a31c77517a472eab8aa05bbe98d6c50814d7990d17696444c0564bfb34"

  depends_on "cmake" => :build

  def install
    # deps/cmake-git-version-tracking declares an ancient cmake_minimum_required
    # that CMake 4 rejects; CMAKE_INSTALL_RPATH lets the tools (e.g. MXFDump)
    # find libMXF in this keg's lib. The empty CMAKE_PROJECT_TOP_LEVEL_INCLUDES
    # overrides Homebrew's FetchContent trap, which otherwise blocks the
    # git-version dep even though it populates from bundled source (no network).
    # Build only the libMXF subproject.
    system "cmake", "-S", "deps/libMXF", "-B", "build",
           "-DCMAKE_POLICY_VERSION_MINIMUM=3.5",
           "-DCMAKE_INSTALL_RPATH=#{rpath}",
           *std_cmake_args,
           "-DCMAKE_PROJECT_TOP_LEVEL_INCLUDES="
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
