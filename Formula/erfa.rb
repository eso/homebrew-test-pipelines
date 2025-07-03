class Erfa < Formula
  desc "Essential Routines for Fundamental Astronomy"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/erfa/erfa-2.0.1.tar.gz"
  sha256 "3aae5f93abcd1e9519a4a0a5d6c5c1b70f0b36ca2a15ae4589c5e594f3d8f1c0"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/erfa/"
    regex(/href=.*?erfa[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/eso/homebrew-test-pipelines/releases/download/erfa-2.0.1"
    sha256 cellar: :any,                 arm64_sequoia: "7aae0fc2bb911b2c43caac7f442d16be8c2ee964ef41793355f35718bacd7add"
    sha256 cellar: :any,                 arm64_sonoma:  "1ea494f56568b77fb71b1b83cd9744cd003562002542becd891c0277ad7becb1"
    sha256 cellar: :any,                 ventura:       "3f7792b2a6dd7289162fc8af3d86a9b860256f8167ad7ec45c641bbaeb73d8ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f4aac6c3a7b8027a4b1f35dbc1d6ad862f8d47f41cd9bb891ec1a68ddf396747"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOF
      #include <erfa.h>
      int main()
      {
        double a[3] = {1, 2, 3};
        double b[3];
        eraCp(a, b);
        return 0;
      }
    EOF
    system ENV.cc, "test.c", "-L#{lib}", "-I#{include}", "-lerfa", "-o", "test"
    system "./test"
  end
end
