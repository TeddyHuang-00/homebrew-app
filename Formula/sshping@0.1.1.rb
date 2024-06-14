class SshpingAT011 < Formula
  desc "SSH-based ping that measures interactive character echo latency and file transfer throughput. Pronounced ;'shipping'."
  homepage "https://crates.io/crates/sshping"
  license "MIT"
  version = "0.1.1"

  url "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
  sha256 "4ebe7d07928e575f0ba084bcf13f19177ed83a254b7c4ef8dd5b9573ee1ec0a0"

  depends_on "rust" => :build
  depends_on "openssl"

  def install
    system "cargo", "install", *std_cargo_args
  end

  def test
    assert_match "sshping #{version}", shell_output("#{bin}/sshping -V")
  end
end
