//
//  ProductInfoView.swift
//  DealDash
//
//  Created by Daniel Waiguru on 25/03/2024.
//

import SwiftUI

struct ProductInfoView: View {
    @StateObject var viewModel = ProductInfoViewModel()
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    let productId: Int
    var body: some View {
        ScrollView {
            switch viewModel.state {
            case .success(let data):
                VStack {
                    AsyncImage(url: .init(string: data.image)) { image in
                        image
                            .resizable()
                            .clipped()
                            .background(.clear)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 400)
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.orange)
                            Text(String(data.rating.rate))
                            Text("(\(data.rating.count) reviews)")
                        }
                        Text(data.title)
                            .font(.title2.bold())
                        
                        Text("Description:")
                            .font(.title3)
                        Text(data.description)
                        Spacer()
                    }
                    Spacer(minLength: 40)
                    HStack {
                        Text(data.price, format: .currency(code: "Ksh"))
                            .font(.title2)
                            .bold()
                        Spacer(minLength: 90)
                        PrimaryButton(text: "Add to cart") {
                            modelContext.insert(data.toCartProduct(count: 1))
                            dismiss()
                        }
                    }
                }
                .navigationTitle(data.title)
            default:
                EmptyView()
            }
        }
        .toolbarRole(.editor)
        .navigationBarTitleDisplayMode(.inline)
        .disabled(viewModel.state == .loading)
        .overlay {
            if viewModel.state == .loading {
                ProgressView()
            }
        }
        .alert(isPresented: $viewModel.hasError, error: viewModel.state.errorMessage) {}
        .task {
            await viewModel.getProductById(id: productId)
        }
        .padding()
    }
}

private extension ProductInfoView {
    var content: some View {
        VStack {
            
        }
    }
}

#Preview {
    ProductInfoView(productId: 1)
}
