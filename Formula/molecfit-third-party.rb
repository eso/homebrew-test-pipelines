class MolecfitThirdParty < Formula
  desc "3rd party tools for the Molecfit library"
  homepage "https://www.eso.org/sci/software/pipelines/skytools/molecfit"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/molecfit_third_party/molecfit_third_party-1.9.3.tar"
  sha256 "2786e34accf63385932bad66c39deab8c8faf4c9095a23173146a9820f4f0183"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/molecfit_third_party/"
    regex(/href=.*?molecfit_third_party[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/eso/homebrew-test-pipelines/releases/download/molecfit-third-party-1.9.3"
    sha256 cellar: :any,                 arm64_sequoia: "7e32dbe8e294c2432ef3aee8cfc9264afdde6c90efcb13ca2f092c8e0609de15"
    sha256 cellar: :any,                 arm64_sonoma:  "ae5297739743ff0011e86adc6074d4a41afcc27792da326ae71c27e881c7c5c8"
    sha256 cellar: :any,                 ventura:       "6b83273b4a97c8dc1dbdbed3ec437865a3bc109f103e1cc433ee43a15d2cfb69"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9f4fb0980f643396e4d9148aaf727e04d0f7c1cc0f08e8bb606b61a4542060d8"
  end

  depends_on "gcc"

  def install
    ENV.deparallelize
    system "make", "-f", "BuildThirdParty.mk",
      "prefix=#{prefix}",
      "install"
  end

  test do
    assert_match "2460672", shell_output("echo \"2024 12 27\" | Gregorian2JD")
  end
end
