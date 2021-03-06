class Qt5Sqlcipher < Formula
  desc "Qt5 SQL driver plugin for SQLCipher"
  homepage "https://github.com/blizzard4591/qt5-sqlcipher"
  url "https://github.com/blizzard4591/qt5-sqlcipher/archive/v1.0.11.tar.gz"
  sha256 "3d44217aebe4dd054c13c0619a016457aba2a9dadeffef4dc50c639b276d8177"
  head "https://github.com/blizzard4591/qt5-sqlcipher.git", :using => :git, :shallow => false

  depends_on "cmake" => [:build]
  depends_on "pkg-config" => [:build]
  depends_on "qt"
  depends_on "sqlcipher"

  def install
    args = %w[
      -DCMAKE_BUILD_TYPE=RELEASE
      -DQSQLCIPHER_INSTALL_INTO_QT_PLUGIN_DIRECTORY=Off
    ]

    mktemp do
      system "cmake", buildpath, *(std_cmake_args + args)
      system "make", "install"
    end
  end

  test do
    output = shell_output("#{bin}/qsqlcipher-test")
    assert_match("Success! All tests completed.", output)
  end
end
