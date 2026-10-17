class Sshping < Formula
  desc "SSH-based ping that measures echo latency and transfer speed"
  homepage "https://github.com/TeddyHuang-00/sshping"

  version = "0.5.1"
  url "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
  sha256 "4514b7a0659c8a8cbdf6b95fec9fd26f79ea40fc1482034fef6e0f2391166d0e"
  license "MIT"
  depends_on "rust" => :build
  depends_on "openssl@3"
  on_linux do
    depends_on "zlib"
  end

  def install
    system "cargo", "install", *std_cargo_args
    bash_completion.install "target/release/completions/sshping.bash"
    zsh_completion.install "target/release/completions/_sshping"
    fish_completion.install "target/release/completions/sshping.fish"
    pwsh_completion.install "target/release/completions/_sshping.ps1"
    man.install "target/release/man/sshping.1"
  end

  test do
    assert_match "sshping #{version}", shell_output("#{bin}/sshping -V")
  end
end
