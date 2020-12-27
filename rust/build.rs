extern crate cc;

fn main() {
    cc::Build::new()
        .opt_level(3)
        .file("src/c/main.c")
        .compile("main.a");
}
