class Asm < Formula
  desc "CLI for Agents Secrets Manager: operator-approved secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/Thinkscape/asm/releases/download/v0.9.0/asm-macos-universal.tar.gz"
    sha256 "79e7c27303d6222f79216ba8162a4efb178ef6689e0f169859393ec010c0cd7a"
  elsif Hardware::CPU.arm?
    url "https://github.com/Thinkscape/asm/releases/download/v0.9.0/asm-linux-aarch64.tar.gz"
    sha256 "5782dcf5ec5172ad7ca0b3601b0dd1b927fabfb894491ab90f3d5421eee60711"
  else
    url "https://github.com/Thinkscape/asm/releases/download/v0.9.0/asm-linux-x86_64.tar.gz"
    sha256 "5293a60429150229b29ec98b87b512c6232d492efc94228cb38ba25d88a60a1e"
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
