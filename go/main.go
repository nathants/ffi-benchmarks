package main

// #cgo CFLAGS: -Wall -O3
// #include "main.h"
import "C"

import (
	"fmt"
	"time"
)

//export callback
func callback(x C.int) C.int {
	return (x + 1) % 64
}

func main() {
	start := time.Now()
	res := 0
	for i := 0; i < 100_000_005; i++ {
		res = int(C.trigger_callback(C.int(res)))
	}
	fmt.Printf("%.3f\n", time.Since(start).Seconds())
	fmt.Println(res)
}
