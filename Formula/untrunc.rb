class Untrunc < Formula
  desc "Restore a truncated mp4/mov. Improved version of ponchio/untrunc"
  homepage "https://github.com/anthwlock/untrunc"
  version "v409-a87f33a"
  url "https://github.com/anthwlock/untrunc.git", revision: "a87f33aa36fb0e174eebad92434d2f9fc3a749da"
  license "GPL-2.0-only"
  head "https://github.com/anthwlock/untrunc.git", branch: "master"

  depends_on "ca-certificates" => :build
  depends_on "cmake" => :build
  depends_on "ffmpeg" => :build
  depends_on "git" => :build
  depends_on "wget" => :build
  depends_on "xz" => :build
  depends_on "yasm" => :build

  def install
    ENV.deparallelize
    system "make", "all"
    bin.install "untrunc"
  end

  test do
    system "untrunc -V"
  end
end
