//
//  TextField.swift
//  DealDash
//
//  Created by Daniel Waiguru on 18/02/2024.
//

import SwiftUI

struct ITextField: View {
    let hint: String
    let keyboardType: UIKeyboardType
    @Binding var text: String
    var body: some View {
        TextField(hint, text: $text)
            .frame(maxWidth: .infinity, minHeight: 44)
            .padding(.leading, 10)
            .keyboardType(keyboardType)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.gray.opacity(0.25))
            )
    }
}

#Preview {
    ITextField(hint: "Username", keyboardType: .alphabet, text: .constant(""))
}
