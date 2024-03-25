//
//  ProductInfoViewModel.swift
//  DealDash
//
//  Created by Daniel Waiguru on 25/03/2024.
//

import Foundation
@MainActor
class ProductInfoViewModel: ObservableObject {
    var hasError: Bool = false
    @Published private(set) var state: ResultWrapper<Product> = .empty {
        didSet {
            updateHasError()
        }
    }
    
    func updateHasError() {
        switch state {
            
        case .loading, .empty:
            break
        case  .success( _):
            break
        case .error( _):
            hasError = true
        }
    }
    func getProductById(id: Int) async {
        do {
            let product = try await NetworkingService.shared.perform(.getProduct(id: id), type: Product.self)
            state = .success(data: product)
        } catch {
            state = .error(error: DealDashError.system(error: error))
        }
    }
}
