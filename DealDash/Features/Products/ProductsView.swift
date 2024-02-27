//
//  ProductsView.swift
//  DealDash
//
//  Created by Daniel Waiguru on 20/02/2024.
//

import SwiftUI

struct ProductsView: View {
    @StateObject private var viewModel = ProductsViewModel()
    private let adaptiveColumn = [GridItem(.adaptive(minimum: 150))]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumn, spacing: 12) {
                ForEach(viewModel.products, id: \.id) { product in
                    ProductItem(product: product)
                }
            }
            .padding()
        }
        .disabled(viewModel.isLoading)
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .task {
            await viewModel.getProducts()
        }
        .alert(isPresented: $viewModel.hasError, error: viewModel.error) {}
        .navigationTitle("DealDash")
    }
}

#Preview {
    ProductsView()
}
