//
//  ProductsViewModel.swift
//  DealDash
//
//  Created by Daniel Waiguru on 27/02/2024.
//

import Foundation
@MainActor
class ProductsViewModel: ObservableObject {
    @Published var hasError = false
    @Published private(set) var state: ProductsUIState = .loading
    
    func getProducts() async {
        do {
            let products = try await NetworkingService.shared.perform(.getProducts, type: [Product].self)
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
