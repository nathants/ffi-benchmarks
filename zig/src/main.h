
#include <stdint.h>

typedef int32_t (*callback)(int32_t);
callback cb;

int32_t register_callback(callback _cb) {
    cb = _cb;
    return 0;
}

int32_t trigger_callback(const int32_t x) {
    return cb((x+1)%64);
}
