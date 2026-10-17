class Sshping < Formula
  desc "SSH-based ping that measures echo latency and transfer speed"
  homepage "https://github.com/TeddyHuang-00/sshping"

  bottle do
    root_url "https://github.com/TeddyHuang-00/homebrew-app/releases/download/sshping-0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "3a1422d1e091b147178656bdd55da56d5a1460193ec5092ad48f0a7372556039"
    sha256 cellar: :any,                 arm64_linux:  "a5f0816e183775b26c69011f4e414edafccc60b0b633bee96a0fd18a8011e82c"
    sha256 cellar: :any,                 x86_64_linux: "4ae90d7cabf01951a715a835269914970182a9dc0c662e0c128232605491d8c7"
  end

  version = "0.5.0"
  url "https://github.com/TeddyHuang-00/sshping/archive/refs/tags/v#{version}.tar.gz"
  sha256 "3853aa7e41691d1b8ad41d08389851effba1f62a9a46145e0a302361c3389f84"
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
