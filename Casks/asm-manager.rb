cask "asm-manager" do
  version "0.12.0"
  sha256 "d2c130af1c986bea37f3350b13eb5ae5f2bd92f54874631879d13b6d00731d49"

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
