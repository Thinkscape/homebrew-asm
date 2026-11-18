cask "asm-manager" do
  version "0.4.0"
  sha256 "0f3bbd32e37863f17340c7b367bcd614f9f1628910a84cd6e82b16d8076e2ad5"

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
