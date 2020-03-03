#! /bin/sh

export PATH=/usr/local/opt/llvm/bin:$PATH

wavm run --mount-root . --enable all-proposed --precompiled \
    ./qjsc -e -o bench/test.c \
    -flto -fno-eval -fno-bigint -fno-module-loader -fno-proxy bench/test.js

clang --target=wasm32-wasi --sysroot=/opt/wasi-libc \
    -I . bench/test.c libquickjs.lto.a -flto -O2 -msimd128 -s -o bench/test.wasm

wavm compile --enable all-proposed bench/test.wasm bench/test.wasm.precompiled &&
    mv -f bench/test.wasm.precompiled bench/test.wasm

wavm run --enable all-proposed --precompiled bench/test.wasm
