class Gq < Formula
  desc "Probes the cards, filters and selects, sets visibility, and runs one command"
  homepage "https://github.com/TeddyHuang-00/gq"
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
