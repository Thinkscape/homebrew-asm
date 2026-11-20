class Asm < Formula
  desc "CLI for Agents Secrets Manager: operator-approved secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/Thinkscape/asm/releases/download/v0.6.1/asm-macos-universal.tar.gz"
    sha256 "16b85d3fe795d8085159e400e8895b594db358ea205167621bc2074a56546bcf"
  elsif Hardware::CPU.arm?
    url "https://github.com/Thinkscape/asm/releases/download/v0.6.1/asm-linux-aarch64.tar.gz"
    sha256 "5a1b483e2d3f901ce8502d23c675f5c51c806451bbf508ce3b4e5d28605a7cb9"
  else
    url "https://github.com/Thinkscape/asm/releases/download/v0.6.1/asm-linux-x86_64.tar.gz"
    sha256 "aee66691abd353a2d86ed2a524259be950dd6fc6195be168b372a5a23570e4ac"
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
