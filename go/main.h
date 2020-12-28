
#include <stdint.h>

static int trigger_callback(const int32_t x) {
    return callback((x + 1) % 64);
}
