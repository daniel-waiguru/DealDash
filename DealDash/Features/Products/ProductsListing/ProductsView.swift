//
//  ProductsView.swift
//  DealDash
//
//  Created by Daniel Waiguru on 20/02/2024.
//

import SwiftUI

struct ProductsView: View {
    @StateObject private var viewModel = ProductsViewModel()
    @State private var showDetail: Bool = false
    @State private var showSettings: Bool = false
    @State private var showCart: Bool = false
    private let adaptiveColumn = [GridItem(.adaptive(minimum: 150))]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumn, spacing: 12) {
                ForEach(viewModel.products, id: \.id) { product in
                    NavigationLink(destination: {ProductInfoView(productId: product.id)}) {
                        ProductItem(product: product)
                    }
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
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showCart.toggle()
                } label: {
                    Image(systemName: "cart.fill")
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showSettings.toggle()
                } label: {
                    Image(systemName: "person.2.badge.gearshape.fill")
                }
            }
        }
        .navigationDestination(isPresented: $showSettings, destination: { SettingsView() })
        .navigationDestination(isPresented: $showCart) {
            CartView()
        }
    }
}

#Preview {
    ProductsView()
}
