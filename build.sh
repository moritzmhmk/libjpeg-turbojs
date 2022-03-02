#!/bin/sh
mkdir -p build
#(cd build && emconfigure cmake -DCMAKE_BUILD_TYPE=Debug ..) &&

(cd build && emcmake cmake -DBUILD_WEB=OFF ..) &&
(cd build && emmake make VERBOSE=1 -j 16)
cp ./build/src/libjpegturbojs.js ./dist &&
cp ./build/src/libjpegturbojs.wasm ./dist &&

(cd build && emcmake cmake -DBUILD_WEB=ON ..) &&
(cd build && emmake make VERBOSE=1 -j 16)
cp ./build/src/libjpegturbojs.js ./dist/libjpegturbojs.web.js &&

(cd test/node; npm run test)