class Sshping < Formula
  desc "SSH-based ping that measures echo latency and transfer speed"
  homepage "https://github.com/TeddyHuang-00/sshping"

  bottle do
    root_url "https://github.com/TeddyHuang-00/homebrew-app/releases/download/sshping-0.4.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "52e2462680d742b6189df46041683dfeed5d352fa4189516a13414d1a4c2a37c"
    sha256 cellar: :any,                 arm64_linux:  "01c05be8927fe9b5cfe94fa276bcc866962aa909f9c651f93e9760e513bc5d08"
    sha256 cellar: :any,                 x86_64_linux: "7dcb1836f41ecec41f43a1d789b34cda3af5603598190ef9d65052b5e54517dc"
  end
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
