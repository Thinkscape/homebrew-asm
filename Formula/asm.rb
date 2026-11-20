class Asm < Formula
  desc "CLI for Agents Secrets Manager: operator-approved secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/Thinkscape/asm/releases/download/v0.7.0/asm-macos-universal.tar.gz"
    sha256 "bfa84d725c56b4359af97ced984f2dd6d4d362655fc7a1e13efb437aba5f5deb"
  elsif Hardware::CPU.arm?
    url "https://github.com/Thinkscape/asm/releases/download/v0.7.0/asm-linux-aarch64.tar.gz"
    sha256 "52e2db74ad0ad78fd57995caa933bb093e4fe557518f7b66951bd08e11f38358"
  else
    url "https://github.com/Thinkscape/asm/releases/download/v0.7.0/asm-linux-x86_64.tar.gz"
    sha256 "f5fbf7f2800eef6b501e9517ccf65adb8977796ff88785629e8a4426a3dddace"
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
