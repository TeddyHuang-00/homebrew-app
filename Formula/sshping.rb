class Sshping < Formula
  desc "SSH-based ping that measures echo latency and transfer speed"
  homepage "https://github.com/TeddyHuang-00/sshping"

  bottle do
    root_url "https://github.com/TeddyHuang-00/homebrew-app/releases/download/sshping-0.2.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "49644932409bffc590c3f52932fd44a1c06fdee49de84dea0a6fd727d859befe"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "69fb9317b4c045463b137b98ecc6140f3ffac3cd1b1d89df733118ffe1ccca1a"
  end
  version = "0.2.3"
  url "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
  sha256 "0a4cc419f796176fa0396985ce74389ce3171d9ab8a581f1388e1d524d48b681"
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
