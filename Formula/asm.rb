class Asm < Formula
  desc "CLI for Agents Secrets Manager: operator-approved secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/Thinkscape/asm/releases/download/v0.11.0/asm-macos-universal.tar.gz"
    sha256 "5911d06768d1621428dee04d7208c54b0c2762460bee5eaa9b1a08e4bde08f5f"
  elsif Hardware::CPU.arm?
    url "https://github.com/Thinkscape/asm/releases/download/v0.11.0/asm-linux-aarch64.tar.gz"
    sha256 "4343ffb5d40a0dc7e231c79ed20ad55344b1fb69b1fbefae3fab8b01c9324e79"
  else
    url "https://github.com/Thinkscape/asm/releases/download/v0.11.0/asm-linux-x86_64.tar.gz"
    sha256 "634a5304a49a98109ff004c7965c7b99eb92b8667b6e9a28554e85fb9361132d"
  end

  def install
    bin.install "asm"
    pkgshare.install "skill"
  end

  def caveats
    <<~EOS
      Pair this machine with the manager on the operator's Mac:
        asm pair <manager-host>
      Add the agent skill to ~/.agents/skills (rerun after upgrades to keep it current):
        asm skill install
      For agents that read another folder, add e.g. --dir ~/.claude/skills.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/asm --version")
    output = shell_output("#{bin}/asm doctor 2>&1", 1)
    assert_match "FAIL paired", output
  end
end
