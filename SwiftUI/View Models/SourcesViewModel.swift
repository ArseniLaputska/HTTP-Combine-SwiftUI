//
//  SourcesViewModel.swift
//  SwiftUI&Combine
//
//  Created by Arseni Laputska on 23.10.21.
//

import Foundation
import Combine

final class SourcesViewModel: ObservableObject {
  //input
  @Published var searchString: String = ""
  @Published var country: String = "us"
  //output
  @Published var sources = [Source]()
  
  private var validString: AnyPublisher<String, Never> {
    $searchString
      .debounce(for: 0.1, scheduler: RunLoop.main)
      .removeDuplicates()
      .eraseToAnyPublisher()
  }
  
  init() {
    Publishers.CombineLatest($country, validString)
      .flatMap { (country, search) -> AnyPublisher<[Source], Never> in
        NewsAPI.shared.fetchSources(for: country)
          .map{search == "" ? $0 : $0.filter {
            ($0.name?.lowercased().contains(search.lowercased()))!
          }}
          .eraseToAnyPublisher()
      }
      .assign(to: \.sources, on: self)
      .store(in: &canellableSet)
  }
  
  private var canellableSet: Set<AnyCancellable> = []
}
