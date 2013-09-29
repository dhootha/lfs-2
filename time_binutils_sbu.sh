#!/bin/bash
# small script to time a clean build of binutils for SBU calculation
# Section 5.4.1 of LFS 7.4

if [ $(id -un) != "lfs" ]; then
  echo "This script should be run by the lfs user."
  echo "Exiting..."
  exit 1
fi

cd $LFS/sources/binutils-build
make clean # this should fail the first time we run, OK
{ time ( ../binutils-2.23.2/configure --prefix=/tools             \
                                    --with-sysroot=$LFS         \
                                    --with-lib-path=/tools/lib  \
                                    --target=$LFS_TGT           \
                                    --disable-nls               \
                                    --disable-werror;           \
                                    make;                       \
( case $(uname -m) in
  x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
esac ); \
make install; ) } 2>&1 | tee sbu_time
				    
