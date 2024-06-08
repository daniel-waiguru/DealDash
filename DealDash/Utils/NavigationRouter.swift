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
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func pop(n: Int) {
        path.removeLast(n)
    }
}
