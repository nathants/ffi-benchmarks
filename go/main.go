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
	return x + 1
}

func main() {
	start := time.Now()
	res := 0
	for i := 0; i < 10_000_000; i++ {
		res += int(C.trigger_callback(1))
	}
	fmt.Printf("%.3f\n", time.Since(start).Seconds())
	fmt.Println(res)
}
