//
//  SearchViewModel.swift
//  Metchik
//
//  Created by maged on 17/05/2024.
//

import Combine
import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var products: [Product] = []
    
    let coordinator: HomeTabCoordinatorProtocol
    private var searchUseCase: SearchUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: HomeTabCoordinator, searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
        self.coordinator = coordinator
        subscribe()
        
    }
    
    private func subscribe() {
        // Observe changes in the search text and filter products
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                guard let self = self else { return }
                self.searchUseCase.filterProducts(by: searchText)
                
                print("Before----------")
                print("\(self.products)")
                print("Before----------")
            }
            .store(in: &cancellables)
        
        // Observe changes in the filtered products
        searchUseCase.$products
            .sink(receiveValue: { [weak self] products in
                guard let self = self else { return }
                self.products = products
                
                print("After----------")
                print("\(self.products)")
                print("After----------")
            })
            .store(in: &cancellables)
    }
}

extension SearchViewModel {
    func showSearchView() {
        coordinator.showSearchView()
    }
    
}
