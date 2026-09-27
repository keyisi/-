import AppKit

// 画一个 1024px 图标：深蓝底圆角 + 胶片条 + 时钟指针（每秒一帧的含义）
let size = 1024
let img = NSImage(size: NSSize(width: size, height: size))
img.lockFocus()
let rect = NSRect(x: 0, y: 0, width: size, height: size)
let bg = NSBezierPath(roundedRect: rect.insetBy(dx: 64, dy: 64), xRadius: 180, yRadius: 180)
NSColor(calibratedRed: 0.16, green: 0.32, blue: 0.62, alpha: 1).setFill()
bg.fill()

// 胶片条（横向两条高光圆角矩形，中间挖出齿孔）
let film = NSRect(x: 140, y: 400, width: 744, height: 224)
let filmPath = NSBezierPath(roundedRect: film, xRadius: 28, yRadius: 28)
NSColor(calibratedRed: 0.95, green: 0.95, blue: 0.97, alpha: 1).setFill()
filmPath.fill()
NSColor(calibratedRed: 0.16, green: 0.32, blue: 0.62, alpha: 1).setFill()
// 齿孔
var x: CGFloat = 180
while x < 850 {
    NSBezierPath(roundedRect: NSRect(x: x, y: 424, width: 44, height: 36), xRadius: 8, yRadius: 8).fill()
    NSBezierPath(roundedRect: NSRect(x: x, y: 564, width: 44, height: 36), xRadius: 8, yRadius: 8).fill()
    x += 88
}
// 三个"帧"方块，中间一个高亮表示当前帧
let frames: [(NSRect, NSColor)] = [
    (NSRect(x: 210, y: 470, width: 160, height: 84), NSColor(calibratedRed: 0.75, green: 0.8, blue: 0.9, alpha: 1)),
    (NSRect(x: 432, y: 462, width: 160, height: 100), NSColor(calibratedRed: 1.0, green: 0.62, blue: 0.2, alpha: 1)),
    (NSRect(x: 654, y: 470, width: 160, height: 84), NSColor(calibratedRed: 0.75, green: 0.8, blue: 0.9, alpha: 1)),
]
for (r, c) in frames {
    let p = NSBezierPath(roundedRect: r, xRadius: 12, yRadius: 12)
    c.setFill(); p.fill()
}

// 右上角时钟小圆，指针指向上方（1 秒节奏）
let cx: CGFloat = 790, cy: CGFloat = 810, cr: CGFloat = 130
let circle = NSBezierPath(ovalIn: NSRect(x: cx-cr, y: cy-cr, width: 2*cr, height: 2*cr))
NSColor.white.setFill(); circle.fill()
NSColor(calibratedRed: 1.0, green: 0.62, blue: 0.2, alpha: 1).setStroke()
circle.lineWidth = 22; circle.stroke()
// 指针: 12 点方向
let hand = NSBezierPath()
hand.move(to: NSPoint(x: cx, y: cy))
hand.line(to: NSPoint(x: cx, y: cy + 84))
hand.lineWidth = 18
hand.lineCapStyle = .round
NSColor(calibratedRed: 0.16, green: 0.32, blue: 0.62, alpha: 1).setStroke()
hand.stroke()

img.unlockFocus()

let tiff = img.tiffRepresentation!
let rep = NSBitmapImageRep(data: tiff)!
let png = rep.representation(using: .png, properties: [:])!
let out = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "icon_1024.png"
try! png.write(to: URL(fileURLWithPath: out))
print("saved: \(out)")
