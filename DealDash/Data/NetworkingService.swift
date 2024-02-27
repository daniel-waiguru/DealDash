//
//  NetworkingService.swift
//  DealDash
//
//  Created by Daniel Waiguru on 18/02/2024.
//

import Foundation

final class NetworkingService {
    static let shared = NetworkingService()

    private init() {}

    func perform<T: Codable>(_ endpoint: ApiEndpoint, type: T.Type) async throws -> T {

            guard let url = endpoint.url else {
                throw NetworkingError.invalidURL
            }
            let request = buildRequest(from: url, methodType: endpoint.methodType)

            let (data, response) = try await URLSession.shared.data(for: request)
    
            guard let response = response as? HTTPURLResponse,
                  (200...300).contains(response.statusCode) else {
                let errorMessage = try? JSONDecoder().decode(ErrorResponse.self, from: data)
                if errorMessage != nil {
                    throw NetworkingError.serverError(message: errorMessage!.message)
                }
                throw NetworkingError.serverError(message: ErrorResponse.defaultErrorMessage().message)
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let res = try decoder.decode(type, from: data)
            return res
        }
}

struct ErrorResponse: Decodable {
    let message: String
}
extension ErrorResponse {
    static func defaultErrorMessage() -> ErrorResponse {
        return ErrorResponse(message: "Something went wrong!")
    }
}
extension NetworkingService {
    enum NetworkingError: LocalizedError {
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
        case serverError(message: String)
    }
}
extension NetworkingService.NetworkingError {
    var errorDescription: String? {
        switch self {
                case .invalidURL:
                    return "URL isn't valid"
                case .invalidStatusCode:
                    return "Status code falls into the wrong range"
                case .invalidData:
                    return "Response data is invalid"
                case .failedToDecode:
                    return "Failed to decode"
                case .custom(let err):
                    return "Something went wrong \(err.localizedDescription)"
        case .serverError(let message):
            return message
                }
    }
}

private extension NetworkingService {
    func buildRequest(from url: URL, methodType: ApiEndpoint.MethodType) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        switch methodType {
        case.GET:
            request.httpMethod = "GET"
        case.POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        return request
    }
}
