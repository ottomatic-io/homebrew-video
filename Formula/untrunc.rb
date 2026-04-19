class Untrunc < Formula
  desc "Restore a truncated mp4/mov. Improved version of ponchio/untrunc"
  homepage "https://github.com/anthwlock/untrunc"
  version "v388-d286625"
  url "https://github.com/anthwlock/untrunc.git", revision: "d286625fb51bf67b7f8536ce7d0340455d3b208b"
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
