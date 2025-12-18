class Sshping < Formula
  desc "SSH-based ping that measures echo latency and transfer speed"
  homepage "https://github.com/TeddyHuang-00/sshping"
  version = "0.2.3"
  url "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
  sha256 "3e65064c87edab29a6f0253cacfad3f423728ea70f5d24259e61a75ba68fff61"
  license "MIT"

  bottle do
    root_url "https://github.com/TeddyHuang-00/homebrew-app/releases/download/sshping-0.2.2"
    sha256 cellar: :any,                 arm64_sequoia: "3e65064c87edab29a6f0253cacfad3f423728ea70f5d24259e61a75ba68fff61"
    sha256 cellar: :any,                 ventura:       "3e65064c87edab29a6f0253cacfad3f423728ea70f5d24259e61a75ba68fff61"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3e65064c87edab29a6f0253cacfad3f423728ea70f5d24259e61a75ba68fff61"
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
  end

  test do
    assert_match "sshping #{version}", shell_output("#{bin}/sshping -V")
  end
end
