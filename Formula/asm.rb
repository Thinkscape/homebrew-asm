class Asm < Formula
  desc "CLI for Agents Secrets Manager: operator-approved secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/Thinkscape/asm/releases/download/v0.2.2/asm-macos-universal.tar.gz"
    sha256 "115e341e863c9d33f7a222ab98f8f7ba09e43dccb456b2cb5cd72cc28b1c6b73"
  elsif Hardware::CPU.arm?
    url "https://github.com/Thinkscape/asm/releases/download/v0.2.2/asm-linux-aarch64.tar.gz"
    sha256 "cdedb334ef6b865547c738dc184b08889d5218b31362b1759935e7725a56103b"
  else
    url "https://github.com/Thinkscape/asm/releases/download/v0.2.2/asm-linux-x86_64.tar.gz"
    sha256 "c4e4f0e13cadb3f2918e84a1dd55b6675bbfc0c6352b9fbcccb8b1cac85d6f92"
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
