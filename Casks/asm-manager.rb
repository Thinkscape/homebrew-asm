cask "asm-manager" do
  version "0.3.0"
  sha256 "26620eb0e5faa939cba68ae751b7a8fe5dbdf53815b502bd474b951149b27bd4"

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
