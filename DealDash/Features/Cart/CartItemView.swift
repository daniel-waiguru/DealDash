//
//  CartItem.swift
//  DealDash
//
//  Created by Daniel Waiguru on 08/06/2024.
//

import SwiftUI

struct CartItemView: View {
    let cartProduct: CartProduct
    let action: (CartAction) -> Void
    var body: some View {
        HStack {
            AsyncImage(url: .init(string: cartProduct.image)) { image in
                image
                    .resizable()
                    .clipped()
                    .background(.clear)
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: 100, maxHeight: 100)
            VStack(alignment: .leading, spacing: 14) {
                Text(cartProduct.title)
                HStack {
                    Text(cartProduct.totalPrice, format: .currency(code: "Ksh"))
                        .bold()
                    Spacer()
                    HStack {
                        Button {
                            action(CartAction.Subtract)
                        } label: {
                            Image(systemName: "minus.circle")
                                .foregroundColor(.black)
                        }
                        Text(String(cartProduct.count))
                        Button {
                            action(CartAction.Add)
                        } label: {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.background).shadow(color: .text.opacity(0.1), radius: 1, x: 0, y: 1))
    }
}

#Preview {
    CartItemView(cartProduct: CartProduct.previewCartProduct, action: { _ in })
}
