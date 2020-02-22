class Qt5Sqlcipher < Formula
  desc "Qt5 SQL driver plugin for SQLCipher"
  homepage "https://github.com/blizzard4591/qt5-sqlcipher"
  url "https://github.com/blizzard4591/qt5-sqlcipher/archive/v1.0.6.tar.gz"
  sha256 "e0eae584eaa791158e203eda01627a6a2c93bb421eaf231b2b0552163297b26a"
  head "https://github.com/blizzard4591/qt5-sqlcipher.git", :using => :git, :shallow => false

  depends_on "cmake"
  depends_on :macos => :mavericks
  depends_on "pkg-config"
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
    shell_output("#{bin}/qsqlcipher-test", 1)
  end
end
