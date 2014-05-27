require "formula"

# Documentation: http://www.disneyanimation.com/technology/seexpr.html
# This is a fork of the release 1.0.1, which is here :
# https://github.com/tuttleofx/SeExpr/tree/tuttle_rel-1.0.1

class Tuttleofxseexpr < Formula
  homepage "http://www.disneyanimation.com/technology/seexpr.html"
  url "https://codeload.github.com/tuttleofx/SeExpr/zip/tuttle_rel-1.0.1"
  sha1 "bb77a40b997960de849051706c4fba57cdda4f94"

  depends_on "cmake" => :build

  def install
    system "cmake ."
    system "make install"
  end

end

