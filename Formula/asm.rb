class Asm < Formula
  desc "CLI for Agents Secrets Manager: operator-approved secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/Thinkscape/asm/releases/download/v0.2.3/asm-macos-universal.tar.gz"
    sha256 "d691dca0644739bbbf5e8f595389e3121b5b4addc92597a3ebd03e4358b37211"
  elsif Hardware::CPU.arm?
    url "https://github.com/Thinkscape/asm/releases/download/v0.2.3/asm-linux-aarch64.tar.gz"
    sha256 "8e5d4737dc45f11682e623a10be4fdb453382b67acee707f3808e2c1dc26640c"
  else
    url "https://github.com/Thinkscape/asm/releases/download/v0.2.3/asm-linux-x86_64.tar.gz"
    sha256 "4a75c43830da89cda855f633de013ebef18c4205105bd2295cbc6ba63cb50160"
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
