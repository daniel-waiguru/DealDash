//
//  PasswordTextField.swift
//  DealDash
//
//  Created by Daniel Waiguru on 18/02/2024.
//

import SwiftUI

struct PasswordTextField: View {
    let hint: String
    @Binding var text: String
    @State private var isShowingPassword = false
    var body: some View {
        ZStack {
            SecureField(hint, text: $text)
                .opacity(isShowingPassword ? 0 : 1)
                .padding(.leading, 10)
                .disableAutocorrection(true)
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .stroke(Color.gray.opacity(0.25))
                )
            TextField(hint, text: $text)
                .opacity(isShowingPassword ? 1 : 0)
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .stroke(Color.gray.opacity(0.25))
                )
            Button(action: togglePasswordVisibility) {
                Image(systemName: isShowingPassword ? "eye.slash" : "eye")
            }
            //.position(x: text.isEmpty ? UIScreen.main.bounds.width - 50 : CGFloat(text.count * 10) + 50, y: 0)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 10)
        }
        
    }
    func togglePasswordVisibility() {
      isShowingPassword.toggle()
    }
}

#Preview {
    PasswordTextField(hint: "Password", text: .constant(""))
}
