cask "parashoot" do
  version :latest
  sha256 :no_check

  url "https://storage.googleapis.com/parashoot/ParaShoot.pkg"
  name "o/PARASHOOT"
  desc "The safe card eraser"
  homepage "https://ottomatic.io/o/parashoot"

  pkg "ParaShoot.pkg"
  binary "#{appdir}/ParaShoot.app/Contents/MacOS/cli/parashoot"

  livecheck do
    url "https://storage.googleapis.com/parashoot/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true

  depends_on macos: ">= :catalina"

  zap trash: [
    "~/Library/Application Support/ParaShoot",
    "~/Library/Preferences/io.ottomatic.parashoot.plist",
  ]
end
