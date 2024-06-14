class SshpingAT013 < Formula
  desc "SSH-based ping that measures interactive character echo latency and file transfer throughput. Pronounced ;'shipping'."
  homepage "https://crates.io/crates/sshping"
  license "MIT"
  version = "0.1.3"

  url "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
  sha256 "f91db7cab7094950b781d940fdc065b3918a5ef401facb8e632b7407a2e3e079"

  depends_on "rust" => :build
  depends_on "openssl"

  def install
    system "cargo", "install", *std_cargo_args
  end

  def test
    assert_match "sshping #{version}", shell_output("#{bin}/sshping -V")
  end
end
