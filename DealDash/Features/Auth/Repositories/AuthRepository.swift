//
//  AuthRepository.swift
//  DealDash
//
//  Created by Daniel Waiguru on 14/05/2025.
//
import Foundation

protocol AuthRepository {
    func signIn(request: Data) async throws -> SignInResponse
}

class AuthRepositoryImpl: AuthRepository {
    func signIn(request: Data) async throws -> SignInResponse {
        return try await URLSession.shared.post(endpoint: .signIn, body: request, responseType: SignInResponse.self)
    }
}
