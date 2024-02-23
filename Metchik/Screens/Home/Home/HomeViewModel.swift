//
//  MainCategoryViewModel.swift
//  Metchik
//
//  Created by maged on 17/12/2023.
//

import Foundation
import Combine
class HomeViewModel: ObservableObject {
    private let offersUseCase: OffersRepositories = OffersUseCase()
    private let productUseCase: ProductRepositories = ProductUseCase()
    private var cancellables =  Set<AnyCancellable>()
    
    @Published var offers: [Offer] = []
    @Published var categories: [String] = []
    @Published var subCategories: [String] = [] {
        didSet {
            updateProducts()
        }
    }
    @Published var products: [String:[Product]] = [:]
    @Published var selectedCategory: String = "" {
        didSet {
            updateSubCategories()
        }
    }
    
    init() {
        updateOffers()
        updateCategories()
    }
    
    private func updateOffers() {
         offersUseCase.getOffers()
            .sink { [weak self] offers in
                self?.offers = offers
            }.store(in: &cancellables)
    }
    
    private func updateCategories() {
        productUseCase.getCategories()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories in
                self?.categories = categories
                if let firstCategory = categories.first {
                    self?.selectedCategory = firstCategory
                }
            }
            .store(in: &cancellables)
    }
    
    private func updateSubCategories() {
        productUseCase.getSubCategories(category: selectedCategory)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] subCategories in
                self?.subCategories = subCategories
            }
            .store(in: &cancellables)
    }
    
    private func updateProducts() {
        productUseCase.getProducts(category: selectedCategory, subCategories: subCategories)
            .sink {[weak self] product in
            self?.products = product
        }.store(in: &cancellables)
    }
}
