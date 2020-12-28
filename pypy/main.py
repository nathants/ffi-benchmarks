# type: ignore
import time
from cffi import FFI
ffibuilder = FFI()

ffibuilder.cdef(r"""
extern "Python" int _py_callback(const int x);
static int trigger_callback(const int x);
""")


ffibuilder.set_source(
    "_exp",
    r"""

static int _py_callback(const int x);

static int trigger_callback(const int x) {
    return _py_callback((x+1)%64);
}

    """,
    extra_compile_args=['-O3', '-march=native'],
)

ffibuilder.compile()
from _exp import ffi, lib

@ffi.def_extern()
def _py_callback(x):
    return (x + 1) % 64

start = time.monotonic()
res = 0
for _ in range(100_000_005):
    res = lib.trigger_callback(res)
print(round(time.monotonic() - start, 3))
print(res)
