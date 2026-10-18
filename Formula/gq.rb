class Gq < Formula
  desc "Probes the cards, filters and selects, sets visibility, and runs one command"
  homepage "https://github.com/TeddyHuang-00/gq"

  bottle do
    root_url "https://github.com/TeddyHuang-00/homebrew-app/releases/download/gq-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "bcc263fa935848a8b1f6e8c4b8a76f3bc4a5d218830c55d161828deadc9e6c95"
    sha256 cellar: :any,                 arm64_linux:  "593a25169264b53871d81e84465ec0fa9e396217fcf906359a84980bc365b5c5"
    sha256 cellar: :any,                 x86_64_linux: "9ca567a661082b2690bc0c21f6bbbd8bdf8662bc25eaa3de799bf3acc282fc0d"
  end
  version = "0.1.0"
  url "https://github.com/TeddyHuang-00/gq/archive/refs/tags/v#{version}.tar.gz"
  sha256 "8310985e4519793a660e360bb7245e8ab58d3555470c797d8ee0842192b74797"
  license "MIT"

  depends_on "rust" => :build
  on_linux do
    depends_on "zlib"
  end

  def install
    system "cargo", "install", *std_cargo_args
    bash_completion.install "target/release/completions/gq.bash"
    zsh_completion.install "target/release/completions/_gq"
    fish_completion.install "target/release/completions/gq.fish"
    pwsh_completion.install "target/release/completions/_gq.ps1"
    man.install "target/release/man/gq.1"
  end

  test do
    assert_match "gq #{version}", shell_output("#{bin}/gq -V")
  end
end
