//
//  ProductInfoViewModel.swift
//  DealDash
//
//  Created by Daniel Waiguru on 25/03/2024.
//

import Foundation
@MainActor
class ProductInfoViewModel: ObservableObject {
    private let productsRepository: ProductsRepository
    var hasError: Bool = false
    @Published private(set) var state: ResultWrapper<Product> = .empty {
        didSet {
            updateHasError()
        }
    }
    
    init(productsRepository: ProductsRepository) {
        self.productsRepository = productsRepository
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
            let product = try await productsRepository.getProductById(id: id)
            state = .success(data: product)
        } catch {
            state = .error(error: DealDashError.system(error: error))
        }
    }
}
