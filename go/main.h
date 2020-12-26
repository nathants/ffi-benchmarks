
#include <stdint.h>

static int trigger_callback(const int32_t x) {
    callback(x);
    return 0;
}
