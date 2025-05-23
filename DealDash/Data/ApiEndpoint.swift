//
//  ApiEndpoint.swift
//  DealDash
//
//  Created by Daniel Waiguru on 18/02/2024.
//

import Foundation

enum ApiEndpoint {
    case signIn
    case getProducts
    case getProduct(id: Int)
}

extension ApiEndpoint {
    var host: String { "fakestoreapi.com" }

    var path: String {
        switch self {
        case .signIn:
            return "auth/login"
        case .getProducts:
            return "products"
        case .getProduct(let id):
            return "products/\(id)"
        }
    }

    var queryItems: [String: String]? {
            switch self {
            default:
                return nil
            }
        }

}
extension ApiEndpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = "/\(path)/"
        return urlComponents.url
    }
}
enum HTTPMethodType: String {
    case GET
    case POST
}
