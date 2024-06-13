//
//  NavigationRouter.swift
//  DealDash
//
//  Created by Daniel Waiguru on 20/02/2024.
//

import Foundation
import SwiftUI

class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    public enum DealDashDestination: Codable, Hashable {
        case cart, settings
        case productInfo(productId: Int)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func navigate(to destination: DealDashDestination) {
        path.append(destination)
    }
    
    func navigateBack() {
        path.removeLast()
    }
}
