class Asm < Formula
  desc "CLI for Agents Secrets Manager: operator-approved secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/Thinkscape/asm/releases/download/v0.10.0/asm-macos-universal.tar.gz"
    sha256 "01a88adeaaad40a90ab26b304c1fc04cf58ca2de16fa337d50e13aff611a6e7c"
  elsif Hardware::CPU.arm?
    url "https://github.com/Thinkscape/asm/releases/download/v0.10.0/asm-linux-aarch64.tar.gz"
    sha256 "67e2af035eb4498172b5fd047532a5a124dfc2466930c43c565626d4c1e398e7"
  else
    url "https://github.com/Thinkscape/asm/releases/download/v0.10.0/asm-linux-x86_64.tar.gz"
    sha256 "dd6b537e28f00f9d80ba94daa244b3821f2d1d65cddfb5a9df57051b9a8edf71"
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
