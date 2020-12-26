#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <time.h>

typedef int32_t (*callback)(int32_t);
callback cb;

int32_t register_callback(callback callback) {
    cb = callback;
    return 0;
}

int32_t trigger_callback(const int32_t x) {
    return cb(x);
}

int32_t my_callback(const int32_t x) {
    return x + 1;
}

int main(int argc, char **argv) {
    register_callback(my_callback);
    time_t now;
    time_t later;
    time(&now);
    int res = 0;
    for (int i = 0; i < 10000000; i++) {
      res += trigger_callback(1);
    }
    time(&later);
    double seconds = difftime(later, now);
    printf("%.10f\n", seconds);
    printf("%d\n", res);
}
