class Sshping < Formula
  desc "SSH-based ping that measures echo latency and transfer speed"
  homepage "https://github.com/TeddyHuang-00/sshping"

  bottle do
    root_url "https://github.com/TeddyHuang-00/homebrew-app/releases/download/sshping-0.2.2"
    sha256 cellar: :any,                 arm64_sequoia: "c2de9e5c66b7e273c583f7e431cdd9c9326fa7269fb5352901408554cddc4fa2"
    sha256 cellar: :any,                 ventura:       "ff09e1dce98f8265e5b956b9c33603f26b436fa3ffa33bb914d742b9f631a41b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3d8c259f6214182cf30bab44613928da86dd25c022c2b3175f8f81f39c593bce"
  end
  version = "0.2.2"

  url "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
  sha256 "03dc3db16fce47512c20586a7b2dff8d0cff255348a964b8bfc6dd4ddca73501"
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
  end

  test do
    assert_match "sshping #{version}", shell_output("#{bin}/sshping -V")
  end
end
