cask "odailies" do
  version :latest
  sha256 :no_check

  url "https://storage.googleapis.com/odailies/macos/oDAILIES.dmg"
  name "o/DAILIES"
  desc "Smart and easy to use solution to preview and analyze video footage anywhere"
  homepage "https://ottomatic.io/o/dailies"

  app "oⳆDAILIESⳆMANAGER.app"

  livecheck do
    url "https://storage.googleapis.com/odailies/odailies-macos.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true

  depends_on macos: ">= :catalina"

  zap trash: [
    "~/Library/Application Support/io.ottomatic.odailies.mac",
    "~/Library/Preferences/io.ottomatic.odailies.mac.plist",
  ]
end
