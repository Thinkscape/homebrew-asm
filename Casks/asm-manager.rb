cask "asm-manager" do
  version "0.7.0"
  sha256 "a5e8768875aae82eec412f98bf43de18e0a0658063b98b2f53a59c7fe4583b70"

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
