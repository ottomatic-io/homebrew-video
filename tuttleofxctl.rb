require "formula"

#https://github.com/Homebrew/homebrew/commits/master/Library/Formula/tuttleofxctl.rb

class Tuttleofxctl < Formula
  homepage "https://github.com/ampas/CTL"
  url "https://github.com/tuttleofx/CTL.git", :branch => "tuttle_develop"
  version "master"

  depends_on 'cmake' => :build
  depends_on 'ilmbase'

  def install
    system "cmake ."
    system "make install"
  end

end
