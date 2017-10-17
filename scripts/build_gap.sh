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

pwd
ls
# build some packages...
cd pkg
ls

# install latest version of datastructures
git clone https://github.com/gap-packages/datastructures
cd datastructures
ls
./autogen.sh
./configure
make -j4 V=1
cd ../../..

pwd
ls
ls $GAPROOT
ls $GAPROOT/pkg
ln -s $PWD $GAPROOT/pkg/
