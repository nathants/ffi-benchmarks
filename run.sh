#!/bin/bash
set -eou pipefail

indent() {
    sed -r 's/([0-9])/ \1/'
}

(
    echo
    echo c
    cd c
    rm -f ./main
    gcc -flto -O3 -o main main.c
    ./main
) | indent

(
    echo
    echo v
    cd v
    rm -f ./main
    v -prod main.v
    ./main
) | indent

(
    echo
    echo zig
    cd zig
    rm -f ./zig-cache/bin/zig
    zig build -Drelease-safe
    ./zig-cache/bin/zig
) | indent

(
    echo
    echo rust
    cd rust
    rm -f ./target/release/main
    cargo build --release &>/dev/null
    ./target/release/main
) | indent

(
    echo
    echo pypy
    cd pypy
    pypy main.py 2>/dev/null
) | indent

(
    echo
    echo go
    cd go
    rm -f ./main
    go build &>/dev/null
    ./main
) | indent

(
    echo
    echo cpython
    cd pypy
    python main.py 2>/dev/null
) | indent
