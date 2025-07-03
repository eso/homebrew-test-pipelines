class Esorex < Formula
  desc "Execution Tool for European Southern Observatory pipelines"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/esorex-3.13.10.tar.gz"
  sha256 "a989f9c6dbd6bbb6a9c7c678da8a3b7ad7a8c7e29c644b97c371579b45957dd6"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/"
    regex(/href=.*?esorex[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/eso/homebrew-test-pipelines/releases/download/esorex-3.13.10"
    sha256 arm64_sequoia: "954d9fdb581fe4740e6de4d889219e53fbc20af2daaac54a1396c1e4a9820041"
    sha256 arm64_sonoma:  "b91bea1b5a2d4262a7f5d6d4579a9e804fb0f31632a0371a117f543646ef9944"
    sha256 ventura:       "14b6f5616829baf4d1fec3fdd584a7fb9672d7ccfc33a853f0c6827e7a570771"
    sha256 x86_64_linux:  "977a459b043b299987b70c20c4ba7b653085da815412f0c39cb8e700296ac5b3"
  end

  depends_on "cpl@7.3.2"
  depends_on "gsl"
  depends_on "libffi"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-cpl=#{Formula["cpl@7.3.2"].prefix}",
                          "--with-gsl=#{Formula["gsl"].prefix}",
                          "--with-libffi=#{Formula["libffi"].prefix}",
                          "--with-included-ltdl"
    system "make", "install"
    inreplace prefix/"etc/esorex.rc", prefix/"lib/esopipes-plugins", HOMEBREW_PREFIX/"lib/esopipes-plugins"
  end

  test do
    assert_match "ESO Recipe Execution Tool, version #{version}", shell_output("#{bin}/esorex --version")
  end
end
