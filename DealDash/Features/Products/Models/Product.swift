//
//  Product.swift
//  DealDash
//
//  Created by Daniel Waiguru on 27/02/2024.
//

import Foundation
struct Product: Codable, Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let title: String
    let price: Double
    let category: String
    let description: String
    let image: String
    let rating: Rating
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}

extension Product {
    func toCartProduct(count: Int) -> CartProduct {
        return CartProduct(id: id, title: title, price: price, count: count, image: image)
    }
}

func mockProduct(id: Int = 1) -> Product {
    Product(id: id, title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", price: 109.95, category: "men's clothing", description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", rating: .init(rate: 3.9, count: 120))
}
