class Sshping < Formula
  desc "SSH-based ping that measures echo latency and transfer speed"
  homepage "https://github.com/TeddyHuang-00/sshping"
  version = "0.4.1"
  url "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
  sha256 "cd69f1ef2ff779a2ff9f96af3da9f4b8ee7c065ab2894c5eda42313fa96bc97e"
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
