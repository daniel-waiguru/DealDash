//
//  DIContainer.swift
//  DealDash
//
//  Created by Daniel Waiguru on 14/05/2025.
//
import Foundation

class DIContainer {
    static let shared = DIContainer()
    private var appDependencies: [String: Any] = [:]
    
    private init() {}
    
    func register<T>(_ service: T) {
        let key = String(describing: type(of: T.self))
        appDependencies[key] = service
    }
    
    func resolve<T>() -> T {
        let key = String(describing: type(of: T.self))
        guard let dependency = appDependencies[key] as? T else {
            fatalError("Failed to resolve dependency for key \(key)")
        }
        return dependency
    }
}

