#! /bin/sh

export PATH=/usr/local/opt/llvm/bin:$PATH

wavm run --mount-root . --enable all-proposed --precompiled \
    ./qjsc -e -o test-rx.c \
    -flto -fno-eval -fno-bigint -fno-module-loader -fno-proxy test-rx.js

clang --target=wasm32-wasi --sysroot=/opt/wasi-libc \
    -I . test-rx.c libquickjs.lto.a -flto -O2 -msimd128 -s -o test-rx.wasm

wavm compile --enable all-proposed test-rx.wasm test-rx.wasm.precompiled &&
    mv -f test-rx.wasm.precompiled test-rx.wasm

wavm run --enable all-proposed --precompiled test-rx.wasm
