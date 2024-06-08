//
//  CartView.swift
//  DealDash
//
//  Created by Daniel Waiguru on 08/06/2024.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        VStack {
            List {
                
            }
            oderInfoView
            PrimaryButton(text: "Proceed to checkout", onClick: {})
                .padding(.top)
        }
        .padding()
        .navigationTitle("Cart")
        .navigationBarTitleDisplayMode(.inline)
    }
}
private extension CartView {
    var oderInfoView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Order Info")
                .bold()
                .font(.title3)
        
            OrderInfoItem(title: "Sub total", value: 200)
            OrderInfoItem(title: "Delivery charge", value: 40)
            HLine()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .frame(height: 1)
                .foregroundColor(.gray)
            HStack {
                Text("Total")
                    .bold()
                Spacer()
                Text(240, format: .currency(code: "KSH"))
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
}
