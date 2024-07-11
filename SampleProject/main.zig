const std = @import("std");
const nw = @import("NeonWood");

const core = nw.core;

const c = nw.vkImgui.c;

pub const Context = struct {
    pub var NeonObjectTable: nw.core.RttiData = nw.core.RttiData.from(@This());

    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) !*@This() {
        const self = try allocator.create(@This());
        self.* = .{
            .allocator = allocator,
        };
        return self;
    }

    pub fn tick(_: *@This(), _: f64) void {
        _ = c.igBegin("imgui window", null, 0);
        c.igText("Hello world");
        c.igEnd();
    }

    pub fn prepare_game(_: *@This()) !void {}

    pub fn deinit(_: *@This()) void {}
};

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{
        .stack_trace_frames = 20,
    }){};

    defer {
        const cleanupStatus = gpa.deinit();
        if (cleanupStatus == .leak) {
            std.debug.print("gpa cleanup leaked memory\n", .{});
        }
    }
    const memory = core.MemoryTracker;

    memory.MTSetup(std.heap.c_allocator);
    defer memory.MTShutdown();

    var tracker = memory.MTGet().?;
    const allocator = tracker.allocator();

    const args = try nw.getArgs();

    try nw.start_everything_imgui(allocator, .{ .windowName = "NeonWood: ui" }, args);
    defer nw.shutdown_everything(allocator);

    try nw.run_everything(Context);
}
