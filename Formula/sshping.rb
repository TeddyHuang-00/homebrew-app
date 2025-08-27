class Sshping < Formula
  desc "SSH-based ping that measures echo latency and transfer speed"
  homepage "https://github.com/TeddyHuang-00/sshping"
  version = "0.2.2"

  url "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
  sha256 "03dc3db16fce47512c20586a7b2dff8d0cff255348a964b8bfc6dd4ddca73501"
  license "MIT"

  depends_on "rust" => :build

  on_linux do
    depends_on "pkg-config" => :build
  end

  depends_on "openssl@3"

  def install
    system "cargo", "install", *std_cargo_args
    bash_completion.install "target/release/completions/sshping.bash"
    zsh_completion.install "target/release/completions/_sshping"
    fish_completion.install "target/release/completions/sshping.fish"
  end

  test do
    assert_match "sshping #{version}", shell_output("#{bin}/sshping -V")
  end
end
