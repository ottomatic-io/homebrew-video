cask "phantomfuse" do
  version :latest
  sha256 :no_check

  url "https://storage.googleapis.com/phantomfuse/PHANTOMfuse.pkg"
  name "o/PHANTOMFUSE"
  desc "The MacOS driver for Vision Research high-speed cameras"
  homepage "https://ottomatic.io/o/phantomfuse"

  pkg "PHANTOMfuse.pkg"

  auto_updates true

  depends_on macos: ">= :catalina"

  zap trash: [
    "~/Library/Application Support/PHANTOMfuse",
    "~/Library/Preferences/io.ottomatic.phantomfuse.plist",
  ]
end
