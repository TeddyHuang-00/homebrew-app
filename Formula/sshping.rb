class Sshping < Formula
  desc "SSH-based ping that measures echo latency and transfer speed"
  homepage "https://github.com/TeddyHuang-00/sshping"

  bottle do
    root_url "https://github.com/TeddyHuang-00/homebrew-app/releases/download/sshping-0.3.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "1019df9815509d3f0f2d8f9d8b5a2190fe5b72cb1f2386b418cb33693f7aaee5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0309281d0108d6926200f28fac27bf19a7e276e2c79e50c40fe318f3b781e679"
  end

  version = "0.3.1"

  url "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
  sha256 "a747b1894e6dc6bb93e280fafe97b80b8683bef8cf571a044a3d7e0cc7e0a661"
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
