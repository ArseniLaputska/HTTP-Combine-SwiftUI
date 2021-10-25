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
  @State var articleURL: URL?
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
          }
          .foregroundColor(Color.blue)
          ArticleImage(imageLoader: ImageLoaderCache.shared.loadedFor(
                        article: article))
          
          Text("\(article.description != nil ? article.description! : "")")
            .lineLimit(12)
          
          Button(
            action: {
              self.articleURL = URL(string: article.url!)
              self.shouldPresent = true
            },
            label: {
              Text("\(article.url != nil ? "Read" : "")")
                .foregroundColor(Color.blue)
            }
          )

          Divider()
        } //VStack
        .sheet(isPresented: self.$shouldPresent) {SafariView(url: URL(string: article.url!))}
      } // foreach
    } // list
  }
}

let calendar = Calendar.current
let calendarComponents = DateComponents(calendar: calendar, year: 2021, month: 10, day: 23)
let sampleArticlesList = Article(title: "Bitcoin down to 9K Dollars !!! - The Financial Times", description: "Today Bitcoin had smashed up and down to 9 thousands dollar in some minutes and rise back.", author: "John Miller", urlToImage: "https://time.com/nextadvisor/wp-content/uploads/2021/06/na-bitcoins-big-crash-884x584.jpg", publishedAt: calendar.date(from: calendarComponents)!, source: Source(id: "the-verge", name: "the-verge", description: "", country: "us", category: "general", url: "https://f1news.ru"), url: "https://f1news.ru")

struct ArticlesList_Previews: PreviewProvider {
  static var previews: some View {
    ArticlesList(articles: [sampleArticlesList])
  }
}
