class Telluriccorr < Formula
  desc "Telluric Correction"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/telluriccorr/telluriccorr-4.3.3.tar.gz"
  sha256 "dffc4ef40d7d279f11ab402fc711724b3fd52412331b0baffb6ccf100d3b39d3"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/telluriccorr/"
    regex(/href=.*?telluriccorr[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/eso/homebrew-test-pipelines/releases/download/telluriccorr-4.3.3"
    sha256 arm64_sequoia: "8c5a81cdc79d206c13ba62e6ad412524f55b3f4d1347956f5a221ad19fd3f6bd"
    sha256 arm64_sonoma:  "4b42de653b8c82db934bc956daa601dea279b32cd3cfe6ac120df8863c41190a"
    sha256 ventura:       "cd2358ba9f91450fcdc7b200aedf84fd4270fb44456ade4ca0c15546da73cf96"
    sha256 x86_64_linux:  "39dd34d0de8d77432a5fbfff2f355e57569c378e987767da0fed263e80991f7f"
  end

  depends_on "cpl@7.3.2"
  depends_on "molecfit-third-party"

  uses_from_macos "curl"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--with-cpl=#{Formula["cpl@7.3.2"].prefix}"
    system "make", "install"
  end

  def post_install
    ln_sf "#{Formula["molecfit-third-party"].share}/molecfit/data/hitran", "#{share}/molecfit/data/"
    ln_sf Formula["molecfit-third-party"].bin, prefix
    url = "https://ftp.eso.org/pub/dfs/pipelines/skytools/molecfit/gdas/gdas_profiles_C-70.4-24.6.tar.gz"
    filename = "#{share}/molecfit/data/profiles/gdas/gdas_profiles_C-70.4-24.6.tar.gz"
    system "curl", "-L", "-o", filename, url
  end

  test do
    system "true"
  end
end
