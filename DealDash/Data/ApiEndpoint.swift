//
//  ApiEndpoint.swift
//  DealDash
//
//  Created by Daniel Waiguru on 18/02/2024.
//

import Foundation

enum ApiEndpoint {
    case signIn(data: Data?)
    case getProducts
}

extension ApiEndpoint {
    var host: String { "fakestoreapi.com" }

    var path: String {
        switch self {
        case .signIn:
            return "auth/login"
        case .getProducts:
            return "products"
        }
    }
    var methodType: MethodType {
        switch self {
        case .signIn(let signRequest):
            return .POST(data: signRequest)
        case .getProducts:
            return .GET
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

extension ApiEndpoint {
    enum MethodType {
        case GET
        case POST(data: Data?)
    }
}
