const std = @import("std");
const Builder = std.build.Builder;
const os = std.os;
const fs = std.fs;

pub fn build(b: *Builder) anyerror!void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("zig", "src/main.zig");
    const include_path = try fs.path.join(b.allocator, &[_][]const u8{ b.build_root, "src" });
    errdefer allocator.free(include_path);
    exe.linkSystemLibrary("c");
    exe.addIncludeDir(include_path);
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
