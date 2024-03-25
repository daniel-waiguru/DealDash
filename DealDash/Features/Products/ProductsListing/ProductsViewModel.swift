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
    @Published private (set) var error: DealDashError?
    @Published private (set) var products = [Product]()
    @Published private (set) var isLoading = false
    
    func getProducts() async {
        isLoading = true
        do {
            let products = try await NetworkingService.shared.perform(.getProducts, type: [Product].self)
            self.products = products
            isLoading = false
        } catch {
            hasError = true
            self.error = DealDashError.system(error: error)
            isLoading = false
        }
    }
}
