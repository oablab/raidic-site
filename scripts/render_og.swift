import AppKit

// Renders the Open Graph share image (1200x630) for raidic.app:
// steel-blue gradient, app icon, wordmark, tagline.

let W: CGFloat = 1200, H: CGFloat = 630
let image = NSImage(size: NSSize(width: W, height: H))
image.lockFocus()

// Background gradient
NSGradient(
    starting: NSColor(srgbRed: 0x3C/255, green: 0x64/255, blue: 0x82/255, alpha: 1),
    ending: NSColor(srgbRed: 0x16/255, green: 0x2A/255, blue: 0x3A/255, alpha: 1)
)!.draw(in: NSRect(x: 0, y: 0, width: W, height: H), angle: -90)

// App icon (reuses the shipped iconset PNG)
let iconPath = CommandLine.arguments.count > 2 ? CommandLine.arguments[2] : "assets/icon-256.png"
if let icon = NSImage(contentsOfFile: iconPath) {
    icon.draw(in: NSRect(x: W/2 - 110, y: H - 300, width: 220, height: 220))
}

func drawText(_ text: String, size: CGFloat, weight: NSFont.Weight, color: NSColor, y: CGFloat) {
    let attrs: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: size, weight: weight),
        .foregroundColor: color,
    ]
    let str = NSAttributedString(string: text, attributes: attrs)
    let sz = str.size()
    str.draw(at: NSPoint(x: W/2 - sz.width/2, y: y))
}

drawText("Raidic", size: 84, weight: .bold, color: .white, y: 210)
drawText("AppleRAID, managed. No terminal required.",
         size: 34, weight: .medium,
         color: NSColor.white.withAlphaComponent(0.75), y: 140)
drawText("raidic.app", size: 26, weight: .semibold,
         color: NSColor(srgbRed: 0x9C/255, green: 0xC3/255, blue: 0xDE/255, alpha: 1), y: 62)

image.unlockFocus()

let rep = NSBitmapImageRep(
    bitmapDataPlanes: nil, pixelsWide: Int(W), pixelsHigh: Int(H),
    bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
    colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
rep.size = NSSize(width: W, height: H)
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)
image.draw(in: NSRect(x: 0, y: 0, width: W, height: H))
NSGraphicsContext.restoreGraphicsState()

let out = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "assets/og-image.png"
try! rep.representation(using: .png, properties: [:])!.write(to: URL(fileURLWithPath: out))
print("wrote \(out)")
