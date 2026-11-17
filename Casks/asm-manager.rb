cask "asm-manager" do
  version "0.2.1"
  sha256 "dfdb34f92d6980ba773a8c4ae72f52c8fe8c9b9aafc7e48483719f153dd73442"

  url "https://github.com/Thinkscape/asm/releases/download/v#{version}/Agents-Secrets-Manager-macos.zip"
  name "Agents Secrets Manager"
  desc "Menu bar app that approves and brokers secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"

  depends_on macos: :sonoma

  app "Agents Secrets Manager.app"

  uninstall quit: "net.thinkscape.asm"

  zap trash: "~/Library/Application Support/asm"

  caveats <<~EOS
    Release builds are not notarized by Apple. If macOS refuses to open the app, allow it in
    System Settings > Privacy & Security, or run:
      xattr -dr com.apple.quarantine "#{appdir}/Agents Secrets Manager.app"
  EOS
end
