class Asm < Formula
  desc "CLI for Agents Secrets Manager: operator-approved secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/Thinkscape/asm/releases/download/v0.1.0/asm-macos-universal.tar.gz"
    sha256 "4d856174dcd00dc2d5d7824070ef0a78f3cf1ef0446bad527e8c6129951c82f5"
  elsif Hardware::CPU.arm?
    url "https://github.com/Thinkscape/asm/releases/download/v0.1.0/asm-linux-aarch64.tar.gz"
    sha256 "d3c66590908d091130a369f251812139995fef6c1149085a29f99c1c59647a2f"
  else
    url "https://github.com/Thinkscape/asm/releases/download/v0.1.0/asm-linux-x86_64.tar.gz"
    sha256 "9ab53c29e9c444d7218a7d1e9368d81690d0e8cefb7cff2efd618d672c683e44"
  end

  def install
    bin.install "asm"
    pkgshare.install "skill"
  end

  def caveats
    <<~EOS
      Pair this machine with the manager on the operator's Mac:
        asm pair <manager-host>
      The agent skill is at:
        #{opt_pkgshare}/skill/asm/SKILL.md
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/asm --version")
    output = shell_output("#{bin}/asm doctor 2>&1", 1)
    assert_match "FAIL paired", output
  end
end
