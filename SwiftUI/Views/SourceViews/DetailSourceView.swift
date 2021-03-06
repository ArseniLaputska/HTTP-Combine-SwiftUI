//
//  DetailSourceView.swift
//  SwiftUI&Combine
//
//  Created by Arseni Laputska on 24.10.21.
//

import SwiftUI

struct DetailSourceView: View {
  var source: Source
  
  @ObservedObject var articlesViewModel: ArticlesViewModel
  @State var shouldPresent: Bool = false
  @State var sourceURL: URL?
  
    var body: some View {
      VStack {
        HStack {
          Text("\(source.name != nil ? source.name! : "")")
          Spacer()
          Text("\(source.category != nil ? source.category! : "")")
          Text("\(source.country != nil ? source.country! : "")")
        } //HStack
        .font(.title)
        Text(source.description != nil ? source.description! : "")
        Button(action: {
          self.sourceURL = URL(string: self.source.url!)
          self.shouldPresent = true
        }, label: {
          Text(source.url != nil ? source.url! : "")
            .foregroundColor(.blue)
        })
        Spacer()
        ZStack {
          Color.gray
          Text("Articles")
            .foregroundColor(.white)
            .font(.largeTitle)
        }
        .frame(height: 40)
        ArticlesList(articles: articlesViewModel.articles)
      } //VStack
      .sheet(isPresented: $shouldPresent) { SafariView(url: self.sourceURL!) }
      .padding(20)
      .navigationBarTitle(Text(source.id!), displayMode: .inline)
    }
}

struct DetailSourceView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSourceView(source: sampleSource1, articlesViewModel: ArticlesViewModel(index: 3, text: "abc-news"))
    }
}
