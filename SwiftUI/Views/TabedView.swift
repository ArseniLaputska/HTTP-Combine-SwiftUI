//
//  TabedView.swift
//  SwiftUI&Combine
//
//  Created by Arseni Laputska on 25.10.21.
//

import SwiftUI

struct TabedView: View {
    var body: some View {
      TabView {
        ArticlesContentView()
          .tabItem {
            Image(systemName: "doc.on.doc.fill")
            Text("Articles")
          }
        SourcesContentView()
          .tabItem {
            Image(systemName: "slider.horizontal.3")
            Text("Sources")
          }
      }
      .accentColor(.blue)
    }
}

struct TabedView_Previews: PreviewProvider {
    static var previews: some View {
        TabedView()
    }
}
