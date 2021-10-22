//
//  ArticlesViewModel.swift
//  SwiftUI
//
//  Created by Arseni Laputska on 22.10.21.
//

import Foundation
import Combine

final class ArticlesViewModel: ObservableObject {
  //input
  @Published var indexPoint: Int = 0
  @Published var searchString: String = "sports"
  //output
  @Published var articles = [Article]()
  
  private var validString: AnyPublisher<String, Never> {
    $searchString
      .debounce(for: 0.1, scheduler: RunLoop.main)
      .removeDuplicates()
      .eraseToAnyPublisher()
  }
  
  init(index: Int = 0, text: String = "sports") {
    self.indexPoint = index
    self.searchString = text
    Publishers.CombineLatest($indexPoint, validString)
      .flatMap { (indexPoint, search) -> AnyPublisher<[Article], Never> in
        self.articles = [Article]()
        return NewsAPI.shared.fetchArtciles(from: Endpoint(index: indexPoint, text: search)!)
      }
      .assign(to: \.articles, on: self)
      .store(in: &self.cancellableSet)
  }
  
  private var cancellableSet: Set<AnyCancellable> = []
}
