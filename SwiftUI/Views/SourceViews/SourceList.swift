//
//  SourceList.swift
//  SwiftUI&Combine
//
//  Created by Arseni Laputska on 24.10.21.
//

import SwiftUI

struct SourceList: View {
  var sources: [Source]
  
    var body: some View {
      List {
        ForEach(sources) { source in
          NavigationLink(destination: DetailSourceView(source: source, articlesViewModel: ArticlesViewModel(index: 3, text: source.id!))) {
            VStack(alignment: .leading) {
              HStack(alignment: .bottom) {
                if UIImage(named: "\(source.id != nil ? source.id! : "")") != nil {
                  Image(uiImage: UIImage(named: "\(source.id != nil ? source.id! : "")")!)
                    .resizable()
                    .frame(width: 60, height: 60)
                }
                Text("\(source.name != nil ? source.name! : "")")
                  .font(.title)
                Text("\(source.country != nil ? source.country! : "")")
              }
              Text("\(source.description != nil ? source.description! : "")")
                .lineLimit(3)
            } // VStack
          } //NavigationLink
        } //ForEach
      } //List
      .navigationBarTitle("Sources")
    } // body
}

let sampleSource1 = Source(id: "abc-news", name: "ABC News", description: "Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.", country: "us", category: "general", url: "https://abcnews.go.com")

let sampleSource2 = Source(id: "cnbc", name: "CNBC", description:"Get latest business news on stock markets, financial & earnings on CNBC. View world markets streaming charts & video; check stock tickers and quotes." , country: "us", category: "business", url: "http://www.cnbc.com")

struct SourceList_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        SourceList(sources: [sampleSource1, sampleSource2])
      }
    }
}
