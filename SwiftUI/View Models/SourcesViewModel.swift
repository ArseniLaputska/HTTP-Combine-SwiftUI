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
  @Published var sourcesError: NewsError?
  
  private var validString: AnyPublisher<String, Never> {
    $searchString
      .debounce(for: 0.1, scheduler: RunLoop.main)
      .removeDuplicates()
      .eraseToAnyPublisher()
  }
  
  init() {
    Publishers.CombineLatest($country, validString)
      .setFailureType(to: NewsError.self)
      .flatMap { (country, search) -> AnyPublisher<[Source], NewsError> in
        NewsAPI.shared.fetchSourcesError(for: country)
          .map{search == "" ? $0 : $0.filter {
            ($0.name?.lowercased().contains(search.lowercased()))!
          }}
          .eraseToAnyPublisher()
      }
      .sink(receiveCompletion: { [unowned self] (completion) in
        if case let .failure(error) = completion {
          self.sourcesError = error
        }
      }, receiveValue: { [unowned self] in
        self.sources = $0
      })
      .store(in: &canellableSet)
  }
  
  private var canellableSet: Set<AnyCancellable> = []
}
