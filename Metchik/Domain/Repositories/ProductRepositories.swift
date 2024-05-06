//
//  ProductRepositories.swift
//  Metchik
//
//  Created by Hassan on 17/02/2024.
//

import Foundation
import Combine
protocol ProductRepositories {
    var productsPublisher: AnyPublisher<Result<[Product], RemoteError>, Never> { get  }
    func getSubCategories(category: String, completion: @escaping ([String]) -> Void)
    func getProducts(category: String, subCategories: [String], completion: @escaping ([String : [Product]]) -> Void)
    func getProducts(category: String, subCategory: String, completion: @escaping ([Product]) -> Void)
    func getProducts(by id: [String], completion: @escaping (Result<[Product], RemoteError>) -> Void)
}
