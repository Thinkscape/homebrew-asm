class Asm < Formula
  desc "CLI for Agents Secrets Manager: operator-approved secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/Thinkscape/asm/releases/download/v0.4.0/asm-macos-universal.tar.gz"
    sha256 "99d1d0bd9aca7d56ecfa60d6f1e029d1a0911f68792eeb25c69c2901f477ab96"
  elsif Hardware::CPU.arm?
    url "https://github.com/Thinkscape/asm/releases/download/v0.4.0/asm-linux-aarch64.tar.gz"
    sha256 "b37d7ffc3bd0ebb7fde7461edf7527d4369ea1dd79a13a549fa49b7eafd8b8f2"
  else
    url "https://github.com/Thinkscape/asm/releases/download/v0.4.0/asm-linux-x86_64.tar.gz"
    sha256 "6e5e6cad4b104c026e2d506a036dc0767acfb3fb545bc9d21137080a4ec03989"
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
