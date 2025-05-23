//
//  SignInViewModel.swift
//  DealDash
//
//  Created by Daniel Waiguru on 18/02/2024.
//

import Foundation
import SwiftUI
@MainActor
class SignInViewModel: ObservableObject {
    private let authRepository: AuthRepository
    @Published var signInRequest = SignInRequest()
    
    var hasError: Bool = false
    @Published private(set) var state: ResultWrapper<String> = .empty {
        didSet {
            updateHasError()
        }
    }
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func updateHasError() {
        switch state {
            
        case .loading, .empty:
            break
        case  .success( _):
            break
        case .error( _):
            hasError = true
        }
    }
    
 
    func signIn() async {
        state = .loading
        if signInRequest.username.isEmpty {
            state = .error(error: DealDashError.appError(error: "Username is required"))
            return
        }
        if signInRequest.password.isEmpty {
            state = .error(error: DealDashError.appError(error: "Password is required"))
            return
        }
        do {
            let request = try JSONEncoder().encode(signInRequest)
            let response = try await authRepository.signIn(request: request)
            UserDefaults.standard.setValue(response.token, forKey: Constants.ACCESS_TOKEN_KEY)
            UserDefaults.standard.setValue(signInRequest.username, forKey: Constants.USERNAME_KEY)
            state = .success(data: signInRequest.username)
        } catch {
            debugPrint("Error: \(error)")
            state = .error(error: DealDashError.system(error: error))
        }
    }
}
