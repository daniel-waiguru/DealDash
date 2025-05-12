//
//  CartView.swift
//  DealDash
//
//  Created by Daniel Waiguru on 08/06/2024.
//

import SwiftUI
import SwiftData

struct CartView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var cartProducts: [CartProduct]
    let deliveryCharge = 40.00
    var body: some View {
        VStack {
            cartItemsListView
            Spacer()
            oderInfoView
            PrimaryButton(text: "Proceed to checkout", onClick: {})
                .padding(.top)
        }
        .padding()
        .navigationTitle("Cart")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    try? modelContext.delete(model: CartProduct.self, includeSubclasses: true)
                } label: {
                    Text("Clear")
                }
            }
        }
    }
    func onActionProduct(action: CartAction, product: CartProduct) {
        switch action {
        case .Add:
            product.updateCount(newCount: product.count + 1)
            modelContext.insert(product)
        case .Subtract:
            if product.count == 1 { return }
            product.updateCount(newCount: product.count - 1)
            modelContext.insert(product)
        }
    }
    
    @ViewBuilder
    private var cartItemsListView: some View {
        if cartProducts.isEmpty {
            InfoView(title: "No Product Found", description: "Add products to your cart")
        } else {
            ForEach(cartProducts, id: \.id) { cartProduct in
                CartItemView(
                    cartProduct: cartProduct,
                    action: { action in
                        onActionProduct(action: action, product: cartProduct)
                    }
                )
            }
        }
    }
}
private extension CartView {
    var oderInfoView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Order Info")
                .bold()
                .font(.title3)
        
            OrderInfoItem(title: "Sub total", value: cartProducts.sum())
            OrderInfoItem(title: "Delivery charge", value: deliveryCharge)
            HLine()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .frame(height: 1)
                .foregroundColor(.gray)
            HStack {
                Text("Total")
                    .bold()
                Spacer()
                Text(deliveryCharge + cartProducts.sum(), format: .currency(code: "KSH"))
                    .bold()
            }
        }
    }
}

private struct OrderInfoItem: View {
    let title: String
    let value: Double
    var body: some View {
        HStack {
            Text("\(title):")
                .foregroundColor(.gray)
            Spacer()
            Text(value, format: .currency(code: "KSH"))
                .bold()
        }
    }
}

#Preview {
    CartView()
        .modelContainer(for: CartProduct.self)
}
