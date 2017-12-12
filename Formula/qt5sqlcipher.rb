class Qt5sqlcipher < Formula
  desc "A Qt5 SQL driver plugin for SQLCipher."
  homepage "https://github.com/blizzard4591/qt5-sqlcipher"
  url "https://github.com/blizzard4591/qt5-sqlcipher/archive/1.0.0.zip"
  version "1.0.0"
  sha256 "6788abb6d49742ea49ec387e0177b2101dce16f4a42bf2292ac249e4c2459297"
  head "https://github.com/blizzard4591/qt5-sqlcipher.git", :using => :git, :shallow => false

  depends_on :macos => :mavericks
  depends_on "cmake"
  depends_on "qt5"
  depends_on "blizzard4591/homebrew-qt5-sqlcipher/sqlcipher"

  def install
    args = %w[
      -DCMAKE_BUILD_TYPE=RELEASE
    ]

    mktemp do
      system "cmake", buildpath, *(std_cmake_args + args)
      system "make", "install"
    end
  end

  test do
    shell_output("#{bin}/qsqlcipher-test", 1)
  end
end
