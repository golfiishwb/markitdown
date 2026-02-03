import SwiftUI
import WebKit

#if os(iOS)
struct WebView: UIViewRepresentable {
    let htmlResourceName: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.bounces = false
        webView.scrollView.alwaysBounceVertical = false
        webView.isOpaque = false
        webView.backgroundColor = .clear
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url = Bundle.main.url(forResource: htmlResourceName, withExtension: "html") else {
            webView.loadHTMLString("<h1>Missing HTML resource: \(htmlResourceName).html</h1>", baseURL: nil)
            return
        }
        webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
    }
}
#else
struct WebView: NSViewRepresentable {
    let htmlResourceName: String

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.setValue(false, forKey: "drawsBackground")
        return webView
    }

    func updateNSView(_ webView: WKWebView, context: Context) {
        guard let url = Bundle.main.url(forResource: htmlResourceName, withExtension: "html") else {
            webView.loadHTMLString("<h1>Missing HTML resource: \(htmlResourceName).html</h1>", baseURL: nil)
            return
        }
        webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
    }
}
#endif
