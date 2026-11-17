class Asm < Formula
  desc "CLI for Agents Secrets Manager: operator-approved secrets for coding agents"
  homepage "https://github.com/Thinkscape/asm"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/Thinkscape/asm/releases/download/v0.2.1/asm-macos-universal.tar.gz"
    sha256 "f0b1fbbecaee8e746e7fa0023d6c48b6225c64c5595ead3ddc03b96d2de37dab"
  elsif Hardware::CPU.arm?
    url "https://github.com/Thinkscape/asm/releases/download/v0.2.1/asm-linux-aarch64.tar.gz"
    sha256 "eeaac291da839b1cbf10b0dd61276db96c7d52c87bac4f904206f1d21177e161"
  else
    url "https://github.com/Thinkscape/asm/releases/download/v0.2.1/asm-linux-x86_64.tar.gz"
    sha256 "028057ee52fd629137d09bbcaa27a865b697bd6a5a9f0ec371c4741a14d37b02"
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
