class Sshping < Formula
  desc "SSH-based ping that measures echo latency and transfer speed"
  homepage "https://github.com/TeddyHuang-00/sshping"
  version = "0.5.1"
  url "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
  sha256 "4514b7a0659c8a8cbdf6b95fec9fd26f79ea40fc1482034fef6e0f2391166d0e"
  license "MIT"

  bottle do
    root_url "https://github.com/TeddyHuang-00/homebrew-app/releases/download/sshping-0.5.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "fc706c1eb4ee0968066ba00325dcaa227b943286f2941af0c8a04bf6d06c5695"
    sha256 cellar: :any,                 arm64_linux:  "d2fa78d821e62d6a0ae84dd09feac98d9a9656a6f91387f02d7aba861a9a6b20"
    sha256 cellar: :any,                 x86_64_linux: "adc4102d5704a591643f35dae2b53453ed10828b010d709d1a4bfabbebb38ffb"
  end

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
    pwsh_completion.install "target/release/completions/_sshping.ps1"
    man.install "target/release/man/sshping.1"
  end

  test do
    assert_match "sshping #{version}", shell_output("#{bin}/sshping -V")
  end
end
