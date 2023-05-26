//
//  SearchViewModel.swift
//  MovieMagic
//
//  Created by Oran Levi on 23/05/2023.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var search: [MovieMagicResult] = []
    @Published var textSearch: String {
        didSet {
            textSearchSubject.send(textSearch)
        }
    }
    @Published var selectedItemId:Int = 0
    @Published var selectedKindMedia: MediaType = .movie
    
    private let searchService: SearchDataService
    
    private var cancellables = Set<AnyCancellable>()
    private let textSearchSubject = PassthroughSubject<String, Never>()
    
    
    init(textSearch: String) {
        self.textSearch = textSearch
        self.searchService = SearchDataService(textSearch: textSearch)
        self.addSubscribers()
    }
    
    private func getSearchData(textSearch: String) {
        searchService.getSearchData(textSearch: textSearch)
    }
    
    private func addSubscribers() {
        
        textSearchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] textSearch in
                self?.getSearchData(textSearch: textSearch)
            }
            .store(in: &cancellables)
        
        searchService.$search
            .sink { [weak self] returnSearch in
                self?.search = returnSearch
            }
            .store(in: &cancellables)
    }
}
