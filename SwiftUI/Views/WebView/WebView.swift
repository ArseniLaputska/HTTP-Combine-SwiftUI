//
//  WebView.swift
//  SwiftUI&Combine
//
//  Created by Arseni Laputska on 25.10.21.
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
  let url: URL?
  
  func makeUIView(context: Context) -> WKWebView {
    return WKWebView()
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
    if let safeString = url {
      if let url = URL(string: "\(safeString)") {
        let request = URLRequest(url: url)
        uiView.load(request)
      }
    }
  }
}
