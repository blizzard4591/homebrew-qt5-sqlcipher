class Qt5sqlcipher < Formula
  desc "A Qt5 SQL driver plugin for SQLCipher."
  homepage "https://github.com/blizzard4591/qt5-sqlcipher"
  url "https://github.com/blizzard4591/qt5-sqlcipher/archive/1.0.1.zip"
  version "1.0.1"
  sha256 "a47933f16b55ecdced7ed2215642aa38febedcc24a448aafefd5fdfd0ee49bd7"
  head "https://github.com/blizzard4591/qt5-sqlcipher.git", :using => :git, :shallow => false

  depends_on :macos => :mavericks
  depends_on "cmake"
  depends_on "qt5"
  depends_on "blizzard4591/homebrew-qt5-sqlcipher/sqlcipher"

  def install
    args = %w[
      -DCMAKE_BUILD_TYPE=RELEASE
      -DQSQLCIPHER_INSTALL_INTO_QT_PLUGIN_DIRECTORY=On
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
