//
//  ArticlesContentView.swift
//  SwiftUI
//
//  Created by Arseni Laputska on 21.10.21.
//

import SwiftUI
import Combine 

struct ArticlesContentView: View {
  @ObservedObject var articlesViewModel = ArticlesViewModel()
  var body: some View {
    VStack{
      Picker("", selection: $articlesViewModel.indexEndpoint) {
        Text("Headlines").tag(0)
        Text("Search").tag(1)
        Text("Categories").tag(2)
      }
      .pickerStyle(SegmentedPickerStyle())
      if articlesViewModel.indexEndpoint == 1 {
        SearchView(searchTerm: self.$articlesViewModel.searchString)
      }
      if articlesViewModel.indexEndpoint == 2 {
        Picker("", selection: $articlesViewModel.searchString) {
          Text("Sports").tag("sports")
          Text("Health").tag("health")
          Text("Science").tag("science")
          Text("Business").tag("business")
          Text("Technology").tag("technology")
        }
        .onAppear(perform: {
          self.articlesViewModel.searchString = "science"
        })
        .pickerStyle(SegmentedPickerStyle())
      }
      ArticlesList(articles: articlesViewModel.articles)
    }
    .alert(item: self.$articlesViewModel.articlesError) { error in
      Alert(
        title: Text("Network error"),
        message: Text(error.localizedDescription).font(.subheadline),
        dismissButton: .default(Text("OK"))
      )
    }
  }
}

struct ArticlesContentView_Previews: PreviewProvider {
  static var previews: some View {
    ArticlesContentView()
  }
}
