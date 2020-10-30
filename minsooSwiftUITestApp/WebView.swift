//
//  WebView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/10/30.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: URL(string: url)!))
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url:"https://m.google.com")
    }
}
