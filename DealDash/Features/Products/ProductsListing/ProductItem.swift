//
//  ProductItem.swift
//  DealDash
//
//  Created by Daniel Waiguru on 27/02/2024.
//

import SwiftUI

struct ProductItem: View {
    let product: Product
    @State private var isLiked = false
    var body: some View {
        ZStack {
            
            VStack(spacing: 5) {
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
                        .font(.headline.bold())
                        .foregroundColor(.text)
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                        Text(String(product.rating.rate))
                            .foregroundColor(.text)
                        Text("(\(product.rating.count))")
                            .foregroundColor(.text)
                    }
                    Text(product.price, format: .currency(code: "Ksh"))
                        .fontWeight(.bold)
                        .foregroundColor(.text)
                }
                .padding(.trailing, 4)
                .padding(.leading, 4)
                .padding(.bottom, 5)
            }
            Button {
                debugPrint("Like clicked")
                isLiked.toggle()
            } label: {
                Image(systemName: isLiked ? "heart.fill" : "heart")
            }
            .padding(6)
            .background(.taintedBackground)
            .clipShape(Circle())
            .position(x: 155, y: 15)
            
            
        }
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.background).shadow(color: .text.opacity(0.1), radius: 1, x: 0, y: 1))

    }
}

#Preview {
    ProductItem(product: Product.previewProduct)
}
