#!/usr/bin/env bash
#Originally from: https://github.com/gap-packages/datastructures/blob/master/scripts/build_gap.sh
#GNU GPL 2: https://github.com/gap-packages/datastructures/blob/master/COPYRIGHT.md
set -ex

# build GAP in a subdirectory
git clone --depth=2 https://github.com/gap-system/gap.git $GAPROOT
cd $GAPROOT
./autogen.sh
./configure
make -j4 V=1
make bootstrap-pkg-minimal

if [[ $ABI == 32 ]]
then
    CONFIGFLAGS="CFLAGS=-m32 LDFLAGS=-m32 LOPTS=-m32 CXXFLAGS=-m32"
fi

# build some packages...
cd pkg

# install latest version of datastructures
git clone https://github.com/gap-packages/datastructures
cd datastructures
./autogen.sh
./configure $CONFIGFLAGS
make -j4 V=1
cd ..
