//
//  SafariView.swift
//  SwiftUI&Combine
//
//  Created by Arseni Laputska on 23.10.21.
//

import SwiftUI
import SafariServices

struct SafariView: View {
  var url: URL?
  
  var body: some View {
    WebView(url: url)
  }
}

struct SafariView_Previews: PreviewProvider {
  static var previews: some View {
    SafariView(url: URL(string: "https://f1news.ru")!)
  }
}
