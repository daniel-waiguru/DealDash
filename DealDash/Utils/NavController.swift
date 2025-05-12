//
//  NavigationRouter.swift
//  DealDash
//
//  Created by Daniel Waiguru on 20/02/2024.
//

import Foundation
import SwiftUI

class NavController: ObservableObject {
    @Published var path = NavigationPath()
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func navigate(to destination: DealDashNavDestination) {
        path.append(destination)
    }
    
    func navigateBack() {
        path.removeLast()
    }
}

public enum DealDashNavDestination: View, Hashable {
    case cart, settings
    case productInfo(productId: Int)
    
    public var body: some View {
        switch self {
        case .cart: CartView()
        case .settings:  SettingsView()
        case .productInfo(let productId): ProductInfoView(productId: productId)
        }
    }
}
