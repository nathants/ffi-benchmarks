package main

// #include "main.h"
import "C"

import (
	"fmt"
	"time"
)

//export callback
func callback(x int) {
	_ = x + 1
}

func main() {
	start := time.Now()
	for i := 0; i < 10_000_000; i++ {
		C.trigger_callback(1)
	}
	fmt.Println(time.Since(start).Seconds())
}
