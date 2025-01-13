#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .

export CFLAGS="${CFLAGS} -Wincompatible-function-pointer-types"
./configure --prefix=${PREFIX}
make
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
make tests
fi
make install
