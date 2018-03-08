#!/usr/bin/env bash
#Originally from: https://github.com/gap-packages/datastructures/blob/master/scripts/build_gap.sh
#GNU GPL 2: https://github.com/gap-packages/datastructures/blob/master/COPYRIGHT.md
set -ex
GAP="$GAPROOT/bin/gap.sh --quitonbreak -q"

$GAP pkg/froidurepin/tst/testall.g
