class Sqlcipherwithcolumn < Formula
  desc "SQLite extension providing 256-bit AES encryption"
  homepage "http://sqlcipher.net"
  url "https://github.com/sqlcipher/sqlcipher/archive/v3.4.1.tar.gz"
  sha256 "4172cc6e5a79d36e178d36bd5cc467a938e08368952659bcd95eccbaf0fa4ad4"
  revision 3

  head "https://github.com/sqlcipher/sqlcipher.git"

  depends_on "openssl"

  # Upstream SQLite patch for CVE-2017-10989
  patch :p0 do
    url "https://sqlite.org/src/vpatch?from=0db20efe201736b3&to=66de6f4a9504ec26"
    sha256 "41d0570cbf80429e556e612acd5eeddcff0e586264a6bcb80bd5a27abc9159a2"
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-tempstore=yes
      --with-crypto-lib=#{Formula["openssl"].opt_prefix}
      --enable-load-extension
      --disable-tcl
    ]

    # Hardcode required flags
    args << "CFLAGS=-DSQLITE_HAS_CODEC -DSQLITE_ENABLE_JSON1 -DSQLITE_ENABLE_FTS3 -DSQLITE_ENABLE_FTS3_PARENTHESIS -DSQLITE_ENABLE_FTS5 -DSQLITE_THREADSAFE=1 -DSQLITE_ENABLE_COLUMN_METADATA=1"
    
    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    path = testpath/"school.sql"
    path.write <<~EOS
      create table students (name text, age integer);
      insert into students (name, age) values ('Bob', 14);
      insert into students (name, age) values ('Sue', 12);
      insert into students (name, age) values ('Tim', json_extract('{"age": 13}', '$.age'));
      select name from students order by age asc;
    EOS

    names = shell_output("#{bin}/sqlcipher < #{path}").strip.split("\n")
    assert_equal %w[Sue Tim Bob], names
  end
end
