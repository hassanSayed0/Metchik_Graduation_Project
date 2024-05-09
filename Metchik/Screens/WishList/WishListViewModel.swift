//
//  WishListViewModel.swift
//  Metchik
//
//  Created by Hassan on 06/05/2024.
//

import SwiftUI
class WishListViewModel: ObservableObject {
    private var wishListUseCase: WishListViewRepositories
    let coordinator: HomeTabCoordinatorProtocol
    @AppStorage("userID") var userID: String?

    @Published var wishListProducts: [WishListProduct] = []
    init(wishListUseCase: WishListViewRepositories, coordinator: HomeTabCoordinatorProtocol) {
        self.wishListUseCase = wishListUseCase
        self.coordinator = coordinator
        getWishListProducts()
    }
    
    func getWishListProducts() {
        if let userID {
            wishListUseCase.getWishListProducts(userID: userID) { wishListProduct in
                self.wishListProducts = wishListProduct
            }
        }
    }
    
    func getProduct(by wishList: WishListProduct) -> Product {
        wishListUseCase.getProduct(by: wishList)
    }
    
    func removeButtonPressed(index: Int) {
        wishListUseCase.removeWishListProduct(wishListID: wishListProducts[index].wishListID) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
