class Asm < Formula
  desc "CLI for Agents Secrets Manager: operator-approved secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/Thinkscape/asm/releases/download/v0.6.0/asm-macos-universal.tar.gz"
    sha256 "b3e4d7d502610f52445ea634643b55456b6bd35023e820a24d892d8a240364cf"
  elsif Hardware::CPU.arm?
    url "https://github.com/Thinkscape/asm/releases/download/v0.6.0/asm-linux-aarch64.tar.gz"
    sha256 "e8f4d6f650d4c7a761f1088c373e4da07c2c8c0fc3ed2def25347531088f2cab"
  else
    url "https://github.com/Thinkscape/asm/releases/download/v0.6.0/asm-linux-x86_64.tar.gz"
    sha256 "0a7018ad35c93a6ee05f069a8eebcb5dc40260cabcf7f5ddaaa0abfd8aa5bf80"
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
