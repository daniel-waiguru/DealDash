//
//  ProductsViewModel.swift
//  DealDash
//
//  Created by Daniel Waiguru on 27/02/2024.
//

import Foundation

@MainActor
class ProductsViewModel: ObservableObject {
    private let productsRepository: ProductsRepository
    
    @Published var hasError = false
    @Published private(set) var state: ProductsUIState = .loading
    
    init(productsRepository: ProductsRepository) {
        self.productsRepository = productsRepository
    }
    
    func getProducts() async {
        state = .loading
        do {
            let products = try await productsRepository.getProducts()
            state = .loaded(products: products)
        } catch {
            state = .failed(error: DealDashError.system(error: error))
        }
    }
}


enum ProductsUIState {
    case loaded(products: [Product])
    case loading
    case failed(error: DealDashError)
}
