const std = @import("std");
const nw = @import("root").neonwood;

pub const GameContext = struct {
    pub var NeonObjectTable: nw.core.RttiData = nw.core.RttiData.from(@This());

    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) !*@This() {
        var self = try allocator.create(@This());
        self.* = .{
            .allocator = allocator,
        };
        return self;
    }

    pub fn prepare_game(self: *@This()) !void {
        _ = self;
    }

    pub fn tick(self: *@This(), dt: f64) void {
        _ = dt;
        _ = self;
    }

    pub fn deinit(self: *@This()) void {
        _ = self;
    }
};

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const cleanupStatus = gpa.deinit();
        if (cleanupStatus == .leak) {
            std.debug.print("gpa cleanup leaked memory\n", .{});
        }
    }
    const allocator = std.heap.c_allocator;

    nw.graphics.setStartupSettings("maxObjectCount", 10);
    try nw.start_everything(allocator, .{ .windowName = "NeonWood: ui" });
    defer nw.shutdown_everything(allocator);
    try nw.run_no_input_tickable(GameContext);
}
