#!/usr/bin/env bash
#Originally from: https://github.com/gap-packages/datastructures/blob/master/scripts/build_gap.sh
#GNU GPL 2: https://github.com/gap-packages/datastructures/blob/master/COPYRIGHT.md
set -ex

# build GAP in a subdirectory
git clone --depth=2 https://github.com/gap-system/gap.git $GAPROOT
cd $GAPROOT
cd hpcgap
git clone https://github.com/gap-system/ward
cd ward
./build.sh
cd ../..
./autogen.sh
./configure --enable-hpcgap
make -j4 V=1
make bootstrap-pkg-minimal

# build some packages...
cd pkg

# install latest version of profiling
git clone https://github.com/gap-packages/profiling
cd profiling
./autogen.sh
# HACK to workaround problems when building with clang
if [[ $CC = clang ]]
then
    export CXX=clang++
fi
./configure $CONFIGFLAGS
make -j4 V=1

# install latest version of datastructures
git clone https://github.com/gap-packages/datastructures
cd datastructures
ls
./autogen.sh
./configure
make -j4 V=1 CPPFLAGS="-I../../extern/install/libatomic_ops/include/ -L../../extern/install/libatomic_ops/lib"
cd ../../..

ls
ls $GAPROOT
ls $GAPROOT/pkg
ln -s $PWD $GAPROOT/pkg/
