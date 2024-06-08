//
//  CartProduct.swift
//  DealDash
//
//  Created by Daniel Waiguru on 08/06/2024.
//

import Foundation
struct CartProduct {
    let id: Int
    let title: String
    let price: Double
    let count: Int
    let image: String
    
    var totalPrice: Double {
        price * Double(count)
    }
}

extension CartProduct {
    static var previewCartProduct = Product.previewProduct.toCartProduct(count: 2)
}
