extern "C" {
    fn register_callback(cb: extern "C" fn(i32) -> i32) -> i32;
    fn trigger_callback(x: i32) -> i32;
}

extern "C" fn callback(a: i32) -> i32 {
    return (a + 1) % 64;
}

fn main() {
    let start = std::time::Instant::now();
    let mut res = 0;
    unsafe {
        register_callback(callback);
        for _ in 0..100_000_005 {
            res = trigger_callback(res);
        }
    }
    let dur = std::time::Instant::now()
        .duration_since(start)
        .as_secs_f64();
    println!("{:.3}", dur);
    println!("{}", res)
}
