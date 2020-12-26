#!/bin/bash
set -eou pipefail


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
    go build &>/dev/null
    ./main
)

(
    echo
    echo rust
    cd rust
    cargo build --release &>/dev/null
    ./target/release/main
)
