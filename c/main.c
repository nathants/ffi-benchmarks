#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include "main.h"

int64_t now_nanos() {
    struct timespec ts;
    timespec_get(&ts, TIME_UTC);
    return (int64_t)ts.tv_sec * 1000000000L + ts.tv_nsec;
}

int32_t my_callback(int32_t x) {
    return (x + 1) % 64;
}

int32_t main(int32_t argc, char **argv) {
    register_callback(my_callback);
    int64_t start = now_nanos();
    int32_t res = 0;
    for (int32_t i = 0; i < 100000005; i++) {
      res = trigger_callback(res);
    }
    double duration = now_nanos() - start;
    printf("%.3f\n", duration/1000000000);
    printf("%d\n", res);
}
