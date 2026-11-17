class Asm < Formula
  desc "CLI for Agents Secrets Manager: operator-approved secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/Thinkscape/asm/releases/download/v0.2.0/asm-macos-universal.tar.gz"
    sha256 "829bcb0c77317c217ae39fd28459d50c2dd66187052b436128ba5b19e353e2da"
  elsif Hardware::CPU.arm?
    url "https://github.com/Thinkscape/asm/releases/download/v0.2.0/asm-linux-aarch64.tar.gz"
    sha256 "648e09d3bbf2e5199535591380c53f462ba22c1c3ffea2e53b128867f1a50074"
  else
    url "https://github.com/Thinkscape/asm/releases/download/v0.2.0/asm-linux-x86_64.tar.gz"
    sha256 "f6182914d229a4e024e672aa2a5f3fbe60c4aa29877f5d34c502d716fc435074"
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
