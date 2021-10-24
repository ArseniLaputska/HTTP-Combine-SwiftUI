//
//  SourcesContentView.swift
//  SwiftUI&Combine
//
//  Created by Arseni Laputska on 23.10.21.
//

import SwiftUI

struct SourcesContentView: View {
  @ObservedObject var sourcesViewModel = SourcesViewModel()
  
    var body: some View {
      NavigationView {
        VStack {
          SearchView(searchTerm: self.$sourcesViewModel.searchString)
          Picker("", selection: self.$sourcesViewModel.country) {
             Text("US").tag("us")
             Text("GB").tag("gb")
             Text("CA").tag("ca")
             Text("RU").tag("ru")
             Text("FR").tag("fr")
             Text("DE").tag("de")
             Text("IT").tag("it")
             Text("IN").tag("in")
             Text("SA").tag("sa")
          }
          .pickerStyle(SegmentedPickerStyle())
          
          SourceList(sources: sourcesViewModel.sources)
        } //VStack
      } //Navigation
    } //body
}

struct SourcesContentView_Previews: PreviewProvider {
    static var previews: some View {
        SourcesContentView()
    }
}
