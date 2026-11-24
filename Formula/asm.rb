class Asm < Formula
  desc "CLI for Agents Secrets Manager: operator-approved secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/Thinkscape/asm/releases/download/v0.8.0/asm-macos-universal.tar.gz"
    sha256 "3abb18f8e0ed353f6f488bacc601d827db3e26ca029c5a37af90e406b1c8d722"
  elsif Hardware::CPU.arm?
    url "https://github.com/Thinkscape/asm/releases/download/v0.8.0/asm-linux-aarch64.tar.gz"
    sha256 "7a51646b85ac302553f6dcfeb51d811f42e55a8d945fc46a8254f8c43c84b749"
  else
    url "https://github.com/Thinkscape/asm/releases/download/v0.8.0/asm-linux-x86_64.tar.gz"
    sha256 "6a34c37d91543c93cc2c5ed85aa75a775a09a8e68bf841eb987b6e3d68de915a"
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
