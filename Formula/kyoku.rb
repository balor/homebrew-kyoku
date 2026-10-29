# Homebrew binary formula for kyoku (tap: balor/kyoku, repo: balor/homebrew-kyoku).
# Installs the prebuilt tarballs produced by .github/workflows/release.yml:
#   kyoku-<version>-<target>.tar.gz  (tarball root dir contains just `kyoku`)
#
# The sha256 placeholders MUST be filled after each release is published:
#   ./update-formula.sh <version>
# (downloads the assets from GitHub Releases, hashes them, rewrites this file)
class Kyoku < Formula
  desc "TUI-first music library manager"
  homepage "https://github.com/balor/kyoku"
  version "0.3.0"
  license "MIT"

  # Binaries are not Apple-notarized / code-signed, but files downloaded by
  # Homebrew itself are never quarantined, so installs work without the
  # Gatekeeper/SmartScreen dance described in the main README.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/balor/kyoku/releases/download/v0.3.0/kyoku-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "4abea9efb8a8ff1082d2db125b866fa6cb56977c971f138c907c5784d48e42c6"
    else
      url "https://github.com/balor/kyoku/releases/download/v0.3.0/kyoku-0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "1e9afe575bbcea626cbe6cca67f349ee95da764290c51f61da0b86c4733181d4"
    end
  end

  on_linux do
    # Only x86_64 Linux tarballs are published for now. aarch64 Linux users
    # should `cargo install kyoku` (takes a couple of minutes, no system deps).
    if Hardware::CPU.arm?
      odie "kyoku has no prebuilt aarch64 Linux binary; use: cargo install kyoku"
    end
    url "https://github.com/balor/kyoku/releases/download/v0.3.0/kyoku-0.3.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "aa485894937879d9b49567a2b868474a495a6c6f9e040f2c603d227503a651c7"
  end

  def install
    bin.install "kyoku"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kyoku --version")
  end
end
