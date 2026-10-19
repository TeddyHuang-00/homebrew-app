class Gq < Formula
  desc "Probes the cards, filters and selects, sets visibility, and runs one command"
  homepage "https://github.com/TeddyHuang-00/gq"
  url "https://github.com/TeddyHuang-00/gq/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "588bef1c0c65aa2a6161ece9db7c34c72784727938996695f57608d5b29ed4ae"
  license "MIT"

  bottle do
    root_url "https://github.com/TeddyHuang-00/homebrew-app/releases/download/gq-0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "de98081d3a1884c602f890e15a8c97c43c4f9b7d78d7f6ec39f277ce4526c2b1"
    sha256 cellar: :any,                 arm64_linux:  "6c0dd0f07f8d9bbb54acffe983eb9660f4f06386b23239bf8522ed454bce4fc9"
    sha256 cellar: :any,                 x86_64_linux: "2c3709d1a3f6885a46a773528610e9ef63f05a703342fd3be19afb3355268354"
  end

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

  version = "0.3.0"

  test do
    assert_match "gq #{version}", shell_output("#{bin}/gq -V")
  end
end
