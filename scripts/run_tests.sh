#!/usr/bin/env bash
#Originally from: https://github.com/gap-packages/datastructures/blob/master/scripts/build_gap.sh
#GNU GPL 2: https://github.com/gap-packages/datastructures/blob/master/COPYRIGHT.md
set -ex
pwd
cd $GAPROOT
cd ..
GAP="$GAPROOT/bin/gap.sh --quitonbreak -q"

$GAP tst/testall.g
