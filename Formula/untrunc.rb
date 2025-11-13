class Untrunc < Formula
  desc "Restore a truncated mp4/mov. Improved version of ponchio/untrunc"
  homepage "https://github.com/anthwlock/untrunc"
  version "v367-13cafed"
  url "https://github.com/anthwlock/untrunc.git", revision: "13cafedf59369db478af537fb909f0d7fd0eb85f"
  license "GPL-2.0-only"
  head "https://github.com/anthwlock/untrunc.git", branch: "master"

  depends_on "ca-certificates" => :build
  depends_on "cmake" => :build
  depends_on "ffmpeg@7" => :build
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
