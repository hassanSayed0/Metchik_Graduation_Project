//
//  ProductUseCase.swift
//  Metchik
//
//  Created by Hassan on 17/02/2024.
//

import Foundation
import Combine

class ProductUseCase: ProductRepositories, ObservableObject {
    private var repo = ProductSourceRepositoriesImpl()
    @Published var products: Result<[Product], RemoteError> = .success([])
    var productsPublisher: AnyPublisher<Result<[Product], RemoteError>, Never> { $products.eraseToAnyPublisher() }
    private var cancellables = Set<AnyCancellable>()
    static var instance = ProductUseCase()
    
    private init() {
        updateProducts()
    }
    
    private func updateProducts() {
        repo.getProductsSource(parameters: [:]) {[weak self] result in
            switch result {
            case .success(let success):
                self?.products = .success(success.data.products.toProducts())
            case .failure(let failure):
                self?.products = .failure(failure)
            }
        }
    }
    
    func getProducts(category: String, subCategory: String, completion: @escaping ([Product]) -> Void) {
        $products
            .sink { result in
                switch result {
                case .success(let products):
                    completion(products.filter {
                        $0.category.lowercased() == category.lowercased() &&
                        $0.subCategory.lowercased() == subCategory.lowercased()
                    })
                case .failure(let failure):
                    print(failure)
                }
            }.store(in: &cancellables)
        
    }
    
    func getProducts(by id: [String], completion: @escaping (Result<[Product], RemoteError>) -> Void) {
        $products
            .sink { result in
                switch result {
                case .success(let products):
                    completion(.success(products.filter { product in
                        id.contains { $0.lowercased() == product.id.lowercased() }
                    }))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
            .store(in: &cancellables)
    }
}
