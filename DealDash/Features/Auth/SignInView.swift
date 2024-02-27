//
//  SignInView.swift
//  DealDash
//
//  Created by Daniel Waiguru on 18/02/2024.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel: SignInViewModel = SignInViewModel()
    @EnvironmentObject var sessionHandler: SessionHandler
    var body: some View {
        VStack(spacing: 16) {
            ITextField(hint: "Username", keyboardType: .alphabet, text: $viewModel.signInRequest.username)
                .padding(.top, 100)
            PasswordTextField(hint: "Password", text: $viewModel.signInRequest.password)
                .padding(.top, 15)
            HStack {
                Spacer()
                NavigationLink {
                    
                } label: {
                    Text("Forgot Password?")
                }
            }
            PrimaryButton(text: "Sign In") {
                Task {
                    await viewModel.signIn()
                }
            }
            .padding(.top, 20)
            Spacer()
        }
        .padding()
        .onChange(of: viewModel.state) { _, newValue in
            switch newValue {
            case .loading, .empty, .error(_):
                break
            case .success(let username):
                sessionHandler.updateSession(as: .loggedIn(username: username))
            }
        }
        .disabled(viewModel.state == .loading)
        .overlay {
            if viewModel.state == .loading {
                ProgressView()
            }
         }
        .alert(isPresented: $viewModel.hasError, error: viewModel.state.errorMessage) {}
        .navigationTitle("Sign In")
    }
}

#Preview {
    SignInView()
        .environmentObject(SessionHandler())
}
