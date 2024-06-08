//
//  CollectionUtils.swift
//  DealDash
//
//  Created by Daniel Waiguru on 08/06/2024.
//

import Foundation

extension [CartProduct] {
    func sum() -> Double {
        return self.reduce(0, { sum, product in sum + product.totalPrice })
    }
}
