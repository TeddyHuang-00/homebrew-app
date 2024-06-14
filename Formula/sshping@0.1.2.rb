class SshpingAT012 < Formula
  desc "SSH-based ping that measures interactive character echo latency and file transfer throughput. Pronounced ;'shipping'."
  homepage "https://crates.io/crates/sshping"
  license "MIT"
  version = "0.1.2"

  url "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
  sha256 "951d7bc35f93b4137cd94128d7c6e18af7c125ac9be1cf507504f6e26ee746be"

  depends_on "rust" => :build
  depends_on "openssl"

  def install
    system "cargo", "install", *std_cargo_args
  end

  def test
    assert_match "sshping #{version}", shell_output("#{bin}/sshping -V")
  end
end
