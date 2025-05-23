//
//  CartProduct.swift
//  DealDash
//
//  Created by Daniel Waiguru on 08/06/2024.
//

import Foundation
import SwiftData

@Model
final class CartProduct {
    @Attribute(.unique)
    let id: Int
    let title: String
    let price: Double
    var count: Int
    let image: String
    
    var totalPrice: Double {
        price * Double(count)
    }
    init(id: Int, title: String, price: Double, count: Int, image: String) {
        self.id = id
        self.title = title
        self.price = price
        self.count = count
        self.image = image
    }
    
    func updateCount(newCount: Int) {
        count = newCount
    }
}

extension CartProduct {
    static var previewCartProduct = mockProduct(id: 1).toCartProduct(count: 2)
}
