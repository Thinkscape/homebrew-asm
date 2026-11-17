class Asm < Formula
  desc "CLI for Agents Secrets Manager: operator-approved secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/Thinkscape/asm/releases/download/v0.3.0/asm-macos-universal.tar.gz"
    sha256 "785e05b7e50789768225ef27fcc9d674ae8b00fa90e69feb9393ca07e529615f"
  elsif Hardware::CPU.arm?
    url "https://github.com/Thinkscape/asm/releases/download/v0.3.0/asm-linux-aarch64.tar.gz"
    sha256 "3d4dcf99222c12cdc8a3fc0ec5f22f3774c2b0131b4face81dfdc02e4af20db2"
  else
    url "https://github.com/Thinkscape/asm/releases/download/v0.3.0/asm-linux-x86_64.tar.gz"
    sha256 "8593ba08eeb0d690be93c0b925c8b627ce122de6e1afb3dcd7f3273c4932cb76"
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
