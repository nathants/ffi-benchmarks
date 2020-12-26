# type: ignore
import time
from cffi import FFI
ffibuilder = FFI()

ffibuilder.cdef(r"""
extern "Python" void _py_callback(const int x);
static int trigger_callback(const int x);
""")


ffibuilder.set_source(
    "_exp",
    r"""

static void _py_callback(const int x);

static int trigger_callback(const int x) {
    _py_callback(x);
    return 0;
}

    """,
    extra_compile_args=['-O3', '-march=native'],
)

ffibuilder.compile()
from _exp import ffi, lib

@ffi.def_extern()
def _py_callback(x):
    _ = x + 1

start = time.monotonic()
for _ in range(10_000_000):
    lib.trigger_callback(1)
print(round(time.monotonic() - start, 3))
