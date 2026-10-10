// Renders a web page to a full-height PNG (for sharing previews). Usage:
//   swift tools/snapshot.swift <url> <out.png> <width> [light|dark]
import AppKit
import WebKit

let args = CommandLine.arguments
let url = URL(string: args[1])!, out = args[2]
let width = CGFloat(Double(args[3]) ?? 390)
let dark = args.count > 4 && args[4] == "dark"

final class Snapper: NSObject, WKNavigationDelegate {
    let window: NSWindow
    let web: WKWebView
    init(width: CGFloat) {
        web = WKWebView(frame: NSRect(x: 0, y: 0, width: width, height: 900))
        window = NSWindow(contentRect: web.frame, styleMask: [.borderless], backing: .buffered, defer: false)
        super.init()
        web.appearance = NSAppearance(named: dark ? .darkAqua : .aqua)
        window.contentView = web
        web.navigationDelegate = self
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            webView.evaluateJavaScript("document.documentElement.scrollHeight") { value, _ in
                let height = CGFloat((value as? NSNumber)?.doubleValue ?? 2000)
                self.window.setContentSize(NSSize(width: width, height: height))
                webView.frame = NSRect(x: 0, y: 0, width: width, height: height)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    let config = WKSnapshotConfiguration()
                    config.rect = NSRect(x: 0, y: 0, width: width, height: height)
                    config.snapshotWidth = NSNumber(value: Double(width * 2))
                    webView.takeSnapshot(with: config) { image, error in
                        guard let image, let tiff = image.tiffRepresentation, let rep = NSBitmapImageRep(data: tiff),
                              let png = rep.representation(using: .png, properties: [:]) else {
                            print("snapshot failed: \(String(describing: error))"); exit(1)
                        }
                        try! png.write(to: URL(fileURLWithPath: out))
                        print("wrote \(out) \(Int(width))x\(Int(height))")
                        exit(0)
                    }
                }
            }
        }
    }
}

let app = NSApplication.shared
app.setActivationPolicy(.prohibited)
let snapper = Snapper(width: width)
snapper.web.load(URLRequest(url: url))
app.run()
