//
//  ProductsRepository.swift
//  DealDash
//
//  Created by Daniel Waiguru on 14/05/2025.
//

import Foundation

protocol ProductsRepository {
    func getProducts() async throws -> [Product]
    
    func getProductById(id: Int)  async throws -> Product
}

class ProductsRepositoryImpl: ProductsRepository {
    func getProductById(id: Int) async throws -> Product {
        return try await URLSession.shared.get(endpoint: .getProduct(id: id), responseType: Product.self)
    }
    
    func getProducts() async throws -> [Product] {
        return try await URLSession.shared.get(endpoint: .getProducts, responseType: [Product].self)
    }

}

class PreviewProductsRepository: ProductsRepository {
    func getProducts() async throws -> [Product] {
        //[mockProduct(id: 1), mockProduct(id: 2), mockProduct(id: 2)]
        []
    }
    
    func getProductById(id: Int) async throws -> Product {
        mockProduct(id: 1)
    }
    
    
}
