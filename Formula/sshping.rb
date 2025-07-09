class Sshping < Formula
  desc "SSH-based ping that measures echo latency and transfer speed"
  homepage "https://crates.io/crates/sshping"
  version = "0.2.1"

  url "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
  sha256 "8cd2622330e296d46a1c316bd87311d411505ce2b43be979819dc7b958d6157c"
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
