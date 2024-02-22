const std = @import("std");
const nwbuild = @import("NeonWood/engine/nwbuild/nwbuild.zig");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const options = b.addOptions();
    options.addOption(bool, "release_build", false);

    var system = nwbuild.NwBuildSystem.init(b, target, optimize, .{});
    _ = system.addGame("SampleProject", "SampleProject", .{});
}
