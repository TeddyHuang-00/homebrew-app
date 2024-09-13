class Sshping < Formula
  desc "SSH-based ping that measures echo latency and transfer speed"
  homepage "https://crates.io/crates/sshping"
  version = "0.1.4"

  url "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
  sha256 "a79c1ba4a6de58fd93e67010a2d15e4dedf84a2e85732a03b1c2acdb018a4f3c"
  license "MIT"

  depends_on "rust" => :build
  depends_on "openssl"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "sshping #{version}", shell_output("#{bin}/sshping -V")
  end
end
