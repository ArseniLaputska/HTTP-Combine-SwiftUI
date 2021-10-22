//
//  ArticlesList.swift
//  SwiftUI&Combine
//
//  Created by Arseni Laputska on 22.10.21.
//

import SwiftUI

struct ArticlesList: View {
  var articles: [Article]
  
  @State var shouldPresent: Bool = false
  @State var articleURl: URL?
  var body: some View {
    List {
      ForEach(articles) { article in
        VStack {
          Text("\(article.title)").font(.title)
          Spacer()
          HStack {
            Text("\(article.source.name != nil ? article.source.name! : "")")
            Spacer()
            Text(APIConstants.formatter.string(from: article.publishedAt!))
              .foregroundColor(.blue)
            ArticleImage(imageLoader: ImageLoaderCache.shared.loadedFor(article: article))
            Text("\(article.description != nil ? article.description! : "")")
          }
        }
      }
    }
  }
}
