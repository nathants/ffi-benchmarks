const std = @import("std");
const c = @cImport(@cInclude("main.h"));
const io = std.io;
const print = io.getStdOut().writer().print;
const time = std.time;
const assert = std.debug.assert;

fn callback(x: i32) callconv(.C) i32 {
    return @mod((x + 1), 64);
}

pub fn main() anyerror!void {
    assert(0 == c.register_callback(callback));
    var start = time.nanoTimestamp();
    var res: i32 = 0;
    var i: i32 = 0;
    while (i < 100_000_005) : (i += 1) {
        res = c.trigger_callback(res);
    }
    try print("{d:.3}\n", .{@intToFloat(f64, time.nanoTimestamp() - start) / 1_000_000_000});
    try print("{}\n", .{res});


}
