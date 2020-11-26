
#!/usr/bin/env zsh

if [ ! -d openssl ]; then
  git clone -b OpenSSL_1_1_1h --depth=1 https://github.com/openssl/openssl.git
fi

cd openssl

if [ -f Makefile ]; then
  make clean
fi

emcmake ./Configure darwin64-x86_64-cc no-shared no-dso no-hw no-engine no-asm

sed -i "" "s/\(^CROSS_COMPILE=.*\)/CROSS_COMPILE=/" Makefile
sed -i "" "s/\(^CNF_CFLAGS=.*\)/CNF_CFLAGS=/" Makefile

emmake make -j8 build_generated libssl.a libcrypto.a
