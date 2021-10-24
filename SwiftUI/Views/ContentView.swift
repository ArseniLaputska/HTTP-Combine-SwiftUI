//
//  ContentView.swift
//  SwiftUI
//
//  Created by Arseni Laputska on 21.10.21.
//

import SwiftUI
import Combine 

struct ContentView: View {
  @ObservedObject var articlesViewModel = ArticlesViewModel()
    var body: some View {
      VStack{
        Picker("", selection: $articlesViewModel.indexPoint) {
          Text("Headlines").tag(0)
          Text("Search").tag(1)
          Text("Categories").tag(2)
        }
        .pickerStyle(SegmentedPickerStyle())
        
        if articlesViewModel.indexPoint == 1 {
          SearchView(searchTerm: self.$articlesViewModel.searchString)
        }
        if articlesViewModel.indexPoint == 2 {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
