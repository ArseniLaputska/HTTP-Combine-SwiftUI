//
//  SafariView.swift
//  SwiftUI&Combine
//
//  Created by Arseni Laputska on 23.10.21.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
  var url: URL
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
    let safariView = SFSafariViewController(url: url)
    safariView.preferredControlTintColor = .black
    return safariView
  }
  
  func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}

struct SafariView_Previews: PreviewProvider {
  static var previews: some View {
    SafariView(url: URL(string: "https://f1news.ru")!)
  }
}
