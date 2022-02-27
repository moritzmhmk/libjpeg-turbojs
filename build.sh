#!/bin/sh
mkdir -p build
#(cd build && emconfigure cmake -DCMAKE_BUILD_TYPE=Debug ..) &&

(cd build && emcmake cmake ..) &&
(cd build && emmake make VERBOSE=1 -j 16)
cp ./build/src/libjpegturbojs.js ./dist &&
cp ./build/src/libjpegturbojs.wasm ./dist &&

(cd test/node; npm run test)