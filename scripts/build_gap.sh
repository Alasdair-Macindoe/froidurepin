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

# install latest version of datastructures
git clone https://github.com/gap-packages/datastructures
cd datastructures
./autogen.sh
./configure CPPFLAGS="-I../../extern/install/libatomic_ops/include/ -L../../extern/install/libatomic_ops/lib"
make -j4 
cd ../../..

# Move FroidurePin
mkdir $GAPROOT/pkg/froidurepin
mv aux $GAPROOT/pkg/froidurepin
mv doc $GAPROOT/pkg/froidurepin
mv gap $GAPROOT/pkg/froidurepin
mv *.g $GAPROOT/pkg/froidurepin
mv LICENSE $GAPROOT/pkg/froidurepin
mv README.md $GAPROOT/pkg/froidurepin
mv tst $GAPROOT/pkg/froidurepin