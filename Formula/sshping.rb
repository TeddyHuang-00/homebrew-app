class Sshping < Formula
  desc "SSH-based ping that measures echo latency and transfer speed"
  homepage "https://github.com/TeddyHuang-00/sshping"

  bottle do
    root_url "https://github.com/TeddyHuang-00/homebrew-app/releases/download/sshping-0.3.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "4a712ec5a0edbca5702ad261dd5a1af35ecd1656f9a9eaab0fa6a36b8850e5ee"
    sha256 cellar: :any,                 arm64_linux:  "27b3251ecfa616811671501104f75e00117351f4005eeefcc190d47b62c8c850"
    sha256 cellar: :any,                 x86_64_linux: "fa08744c2aff70f1b0746a7ee046a7399a45fbb5479bc5f661aa540e7d45966c"
  end

  version = "0.3.2"

  url "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
  sha256 "13d739dc66794dff584fa4f1d736b633761b2a72bdafec450607923e2014d828"
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
