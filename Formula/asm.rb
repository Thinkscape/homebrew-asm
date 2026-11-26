class Asm < Formula
  desc "CLI for Agents Secrets Manager: operator-approved secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/Thinkscape/asm/releases/download/v0.12.0/asm-macos-universal.tar.gz"
    sha256 "cf6d4913a99484e915cfec0393245c4c86b0364362739ddde9427e4514e8754c"
  elsif Hardware::CPU.arm?
    url "https://github.com/Thinkscape/asm/releases/download/v0.12.0/asm-linux-aarch64.tar.gz"
    sha256 "80dffcd1ae2b1ad8ff29e7bc637d601d752fd6f469c461c9ca1cc09e169f8a6b"
  else
    url "https://github.com/Thinkscape/asm/releases/download/v0.12.0/asm-linux-x86_64.tar.gz"
    sha256 "6226e26c18f253524a9d5448bd6ba837398b5ecd75f8f8d64dc264da8e804a62"
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
