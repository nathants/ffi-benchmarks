#!/bin/bash
set -eou pipefail


(
    echo
    echo c
    cd c
    rm -f ./main
    gcc -O3 -o main main.c
    ./main
)

(
    echo
    echo cpython
    cd pypy
    python main.py 2>/dev/null
)

(
    echo
    echo pypy
    cd pypy
    pypy main.py 2>/dev/null
)

(
    echo
    echo go
    cd go
    rm -f ./main
    go build &>/dev/null
    ./main
)

(
    echo
    echo rust
    cd rust
    rm -f ./target/release/main
    cargo build --release &>/dev/null
    ./target/release/main
)

(
    echo
    echo v
    cd v
    v -prod main.v
    ./main
)
