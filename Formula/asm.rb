class Asm < Formula
  desc "CLI for Agents Secrets Manager: operator-approved secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/Thinkscape/asm/releases/download/v0.5.0/asm-macos-universal.tar.gz"
    sha256 "281f23e9a5f9be20efd2a542368a5d48e24f73a058177edb565e89940935003a"
  elsif Hardware::CPU.arm?
    url "https://github.com/Thinkscape/asm/releases/download/v0.5.0/asm-linux-aarch64.tar.gz"
    sha256 "fe7671d24e8a8145cd0a223f72b4adedd08fe76e87b1d32ab31c9c03f60d06b8"
  else
    url "https://github.com/Thinkscape/asm/releases/download/v0.5.0/asm-linux-x86_64.tar.gz"
    sha256 "0cd1a0f59bb306ba889b87d6277c0bfdc8cc106db6962d00012faf5e183ac3cc"
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
