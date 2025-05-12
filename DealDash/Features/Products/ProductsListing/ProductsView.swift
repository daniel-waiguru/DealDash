//
//  ProductsView.swift
//  DealDash
//
//  Created by Daniel Waiguru on 20/02/2024.
//

import SwiftUI
import SwiftData

struct ProductsView: View {
    @StateObject private var viewModel = ProductsViewModel()
    @State private var showDetail: Bool = false
    @EnvironmentObject var navController: NavController
    private let adaptiveColumn = [GridItem(.adaptive(minimum: 150))]
    @Query private var cartItems: [CartProduct]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumn, spacing: 12) {
                ForEach(viewModel.products, id: \.id) { product in
                    Button {
                        navController.navigate(to: .productInfo(productId: product.id))
                    } label: {
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
                    navController.navigate(to: .cart)
                } label: {
                    Image(systemName: "cart.fill")
                }
                .overlay(alignment: .topTrailing) {
                    if cartItems.count > 0 {
                        badge
                    }
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button {
                    navController.navigate(to: .settings)
                } label: {
                    Image(systemName: "person.2.badge.gearshape.fill")
                }
            }
        }
    }
}
private extension ProductsView {
    var badge: some View {
        Text("\(cartItems.count)")
            .foregroundColor(.white)
            .padding(6)
            .font(.caption2.bold())
            .monospacedDigit()
            .background(
                Circle()
                    .fill(.red)
            )
            .offset(x: 2, y: -2)
    }
}

#Preview {
    ProductsView()
        .environmentObject(NavController())
}
