## Build dependencies:

- `wavm` (or set the `QJSC` value in the `Makefile` accordingly)
- LLVM (`brew install llvm`)
- [`libclang_rt.builtins-wasm32.a`](https://github.com/jedisct1/libclang_rt.builtins-wasm32.a)
- [`wasi-sysroot`](https://github.com/WebAssembly/wasi-sdk/releases) installed in `/opt/wasi-sysroot`.

## Compilation (on MacOS):

```sh
export PATH=/usr/local/opt/llvm/bin:$PATH
make
```
