class Sshping < Formula
  desc "SSH-based ping that measures echo latency and transfer speed"
  homepage "https://crates.io/crates/sshping"
  version = "0.2.0"

  url "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
  sha256 "6d1b4ddc5f39cadb9c9f2e8f9dd81db3555d456785a3707e595761ce91b2e474"
  license "MIT"

  depends_on "rust" => :build
  depends_on "openssl"

  def install
    system "cargo", "build", "-r"
    bin.install "target/release/sshping"
    bash_completion.install "target/release/completions/sshping.bash"
    zsh_completion.install "target/release/completions/_sshping"
    fish_completion.install "target/release/completions/sshping.fish"
  end

  test do
    assert_match "sshping #{version}", shell_output("#{bin}/sshping -V")
  end
end
