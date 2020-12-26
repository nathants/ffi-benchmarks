extern crate cc;

fn main() {
    cc::Build::new()
        .flag("-O3")
        .file("src/c/main.c")
        .compile("libexp.a");
}
