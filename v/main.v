module main

import time

#flag -I @VROOT
#flag -O3
#include "main.h"
fn C.register_callback(_cb voidptr) int

fn C.trigger_callback(x int) int

fn my_callback(x int) int {
	return x + 1
}

fn main() {
	C.register_callback(my_callback)
	now := time.now()
	mut res := 0
	for _ in 0 .. 10_000_000 {
		res += C.trigger_callback(1)
	}
	dur := (time.now() - now).seconds()
	println('${dur:.6f}')
	println(res)
}
