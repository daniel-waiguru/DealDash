//
//  PrimaryButton.swift
//  DealDash
//
//  Created by Daniel Waiguru on 18/02/2024.
//

import SwiftUI

struct PrimaryButton: View {
    let text: String
    let onClick: () -> Void
    var body: some View {
        Button(action: onClick) {
            Text(text)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color("colorPrimary"))
        .foregroundColor(.white)
        .font(.system(size: 16, weight: .bold))
        .cornerRadius(10.0)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.clear, lineWidth: 2)
        }
    }
}

#Preview {
    PrimaryButton(text: "Sign In", onClick: {})
}
