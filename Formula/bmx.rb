class Bmx < Formula
  desc "Library and tools for reading and writing MXF and Wave AV files"
  homepage "https://github.com/ebu/bmx"
  # BBC archived bmx/libMXF/libMXF++; EBU now maintains bmx with libMXF and
  # libMXF++ bundled and version-locked under deps/. The libmxf/libmxfpp
  # formulas build those same bundled sources from this tarball, so all three
  # formulas must share this url + sha256.
  url "https://github.com/ebu/bmx/releases/download/v1.7/bmx-1.7.tar.gz"
  sha256 "448242a31c77517a472eab8aa05bbe98d6c50814d7990d17696444c0564bfb34"

  depends_on "cmake" => :build
  depends_on "expat"
  depends_on "libmxf"
  depends_on "libmxfpp"
  depends_on "uriparser"

  def install
    # BMX_BUILD_LIBMXF*_LIB=ON links the external libmxf/libmxfpp formulas via
    # pkg-config instead of the bundled deps/ copies. Notes on the flags:
    #  * CMAKE_POLICY_VERSION_MINIMUM: deps/cmake-git-version-tracking declares
    #    an ancient cmake_minimum_required that CMake 4 rejects.
    #  * CMAKE_INSTALL_INCLUDEDIR: with external libMXF, bmx never pulls in
    #    GNUInstallDirs, leaving the var empty so headers install to /bmx.
    #  * CMAKE_INSTALL_RPATH: lets the tools find libbmx in this keg's lib.
    #  * Empty CMAKE_PROJECT_TOP_LEVEL_INCLUDES overrides Homebrew's FetchContent
    #    trap, which otherwise blocks the (network-free, bundled) git-version dep.
    system "cmake", "-S", ".", "-B", "build",
           "-DCMAKE_POLICY_VERSION_MINIMUM=3.5",
           "-DCMAKE_INSTALL_INCLUDEDIR=include",
           "-DCMAKE_INSTALL_RPATH=#{rpath}",
           "-DBMX_BUILD_LIBMXF_LIB=ON",
           "-DBMX_BUILD_LIBMXFPP_LIB=ON",
           *std_cmake_args,
           "-DCMAKE_PROJECT_TOP_LEVEL_INCLUDES="
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "bmx v#{version}", shell_output("#{bin}/mxf2raw --help 2>&1")
  end
end
