class CplAT732 < Formula
  desc "ISO-C libraries for developing astronomical data-reduction tasks"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/cpl/cpl-7.3.2.tar.gz"
  sha256 "a50c265a8630e61606567d153d3c70025aa958a28473a2411585b96894be7720"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/cpl/"
    regex(/href=.*?cpl[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/eso/homebrew-test-pipelines/releases/download/cpl@7.3.2-7.3.2"
    sha256 cellar: :any,                 arm64_sequoia: "0568f275dc6932077a1c67e98b7087539276158594c5bfa0931130315e7049e8"
    sha256 cellar: :any,                 arm64_sonoma:  "3a3d5d00264db95f88884539b5e345765af86e077a08b35cce9472bd97b26bd5"
    sha256 cellar: :any,                 ventura:       "f082ba2e2333cdde40106db7f2a44216fda34599da0a5bef44e3bd9023db637c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "291ee4ae5d1abfe5821b1dc3511698319b9551823e12f298fa4247476042202e"
  end

  keg_only :versioned_formula

  depends_on "cfitsio"
  depends_on "fftw"
  depends_on "wcslib"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-cfitsio=#{Formula["cfitsio"].prefix}",
                          "--with-fftw=#{Formula["fftw"].prefix}",
                          "--with-wcslib=#{Formula["wcslib"].prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOF
      #include <cpl.h>
      int main(){
        cpl_init(CPL_INIT_DEFAULT);
        cpl_msg_info("hello()", "Hello, world!");
        cpl_end();
        return 0;
      }
    EOF
    system ENV.cc, "test.c", "-L#{lib}", "-I#{include}", "-lcplcore", "-lcext", "-o", "test"
    system "./test"
  end
end
