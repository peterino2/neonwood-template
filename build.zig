const std = @import("std");
const NeonWood = @import("NeonWood");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    var nwbuild = NeonWood.init(b, .{
        .target = target,
        .optimize = optimize,
    });

    _ = nwbuild.addProgram(.{
        .name = "SampleProject",
        .desc = "SampleProject",
        .root_source_file = b.path("SampleProject/main.zig"),
    });
}
