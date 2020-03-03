#! /bin/sh

export PATH=/usr/local/opt/llvm/bin:$PATH

wavm run --mount-root . --enable all-proposed --precompiled \
    ./qjsc -e -o test.c \
    -flto -fno-eval -fno-bigint -fno-module-loader -fno-proxy test.js

clang --target=wasm32-wasi --sysroot=/opt/wasi-libc \
    -I . test.c libquickjs.lto.a -flto -O2 -msimd128 -s -o test.wasm

wavm compile --enable all-proposed test.wasm test.wasm.precompiled &&
    mv -f test.wasm.precompiled test.wasm

wavm run --enable all-proposed --precompiled test.wasm
