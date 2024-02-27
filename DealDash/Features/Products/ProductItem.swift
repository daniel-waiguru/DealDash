//
//  ProductItem.swift
//  DealDash
//
//  Created by Daniel Waiguru on 27/02/2024.
//

import SwiftUI

struct ProductItem: View {
    let product: Product
    var body: some View {
        VStack( spacing: 5) {
            AsyncImage(url: .init(string: product.image)) { image in
                image
                    .resizable()
                    .clipped()
                    .background(.clear)
            
            } placeholder: {
                ProgressView()
            }
            .frame(height: 150)
            .padding()
    
            VStack(alignment: .leading, spacing: 5) {
                Text(product.title)
                    .lineLimit(2)
                    .font(.title3.bold())
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                    Text(String(product.rating.rate))
                    Text("(\(product.rating.count))")
                }
                Text(product.price, format: .currency(code: "Ksh"))
                    .fontWeight(.bold)
            }
            .padding(.trailing, 4)
            .padding(.leading, 4)
            .padding(.bottom, 5)
        }
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.background).shadow(color: .text.opacity(0.1), radius: 1, x: 0, y: 1))

    }
}

#Preview {
    ProductItem(product: Product.previewProduct)
}
