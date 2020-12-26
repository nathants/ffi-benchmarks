extern "C" {
    fn register_callback(cb: extern "C" fn(i32)) -> i32;
    fn trigger_callback(x: i32) -> i32;
}

extern "C" fn callback(a: i32) {
    let _ = a + 1;
}

fn main() {
    let start = std::time::Instant::now();
    unsafe {
        register_callback(callback);
        for _ in 0..10_000_000 {
            trigger_callback(1);
        }
    }
    let dur = std::time::Instant::now()
        .duration_since(start)
        .as_secs_f64();
    println!("{}", dur);
}
