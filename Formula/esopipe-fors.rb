class EsopipeFors < Formula
  desc "ESO FORS instrument pipeline (static data)"
  homepage "https://www.eso.org/sci/software/pipe_aem_table.html"
  url "https://ftp.eso.org/pub/dfs/pipelines/kit_devel/fors-kit-5.8.4-4_svn298403_head.tar.gz"
  sha256 "d1dfd5d40288e7ef8ff7e2e3e83a09382280fadbb2bfd221db633aac40775e36"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?fors-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  depends_on "esopipe-detmon-recipes"
  depends_on "esopipe-esotk"
  depends_on "esopipe-fors-recipes"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "fors-calib-#{version_norevision}.tar.gz"
    (prefix/"share/esopipes/datastatic/fors-#{version_norevision}").install Dir["fors-calib-#{version_norevision}/cal/*"]
  end

  test do
    system "true"
  end
end
