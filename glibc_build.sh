#!/bin/bash
# captures the build steps for glibc from 5.7 of LFS 7.4
# must be run inside the uncompressed glibc directory

if [ ! -r /usr/include/rpc/types.h ]; then
  su -c 'mkdir -p /usr/include/rpc'
  su -c 'cp -v sunrpc/rpc/*.h /usr/include/rpc'
fi

sed -i -e 's/static __m128i/inline &/' sysdeps/x86_64/multiarch/strstr.c

mkdir -v ../glibc-build
cd ../glibc-build

../glibc-2.18/configure                               \
      --prefix=/tools                                 \
      --host=$LFS_TGT                                 \
      --build=$(../glibc-2.18/scripts/config.guess)   \
      --disable-profile                               \
      --enable-kernel=2.6.32                          \
      --with-headers=/tools/include                   \
      libc_cv_forced_unwind=yes                       \
      libc_cv_ctors_header=yes                        \
      libc_cv_c_cleanup=yes

make
make install
