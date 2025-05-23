//
//  ProductsView.swift
//  DealDash
//
//  Created by Daniel Waiguru on 20/02/2024.
//

import SwiftUI
import SwiftData

struct ProductsView: View {
    @StateObject var viewModel: ProductsViewModel
    @State private var showDetail: Bool = false
    @EnvironmentObject var navController: NavController
    @Query private var cartItems: [CartProduct]
    
    init(viewModel: ProductsViewModel = DIContainer.shared.resolve()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            productsView
        }
        .task {
            await viewModel.getProducts()
        }
        .refreshable { await viewModel.getProducts() }
        .padding()
        .navigationTitle("DealDash")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    navController.navigate(to: .cart)
                } label: {
                    Image(systemName: "bag.fill")
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
                    Image(systemName: "gearshape.fill")
                }
            }
        }
    }
    
    @ViewBuilder
    private var productsView: some View {
        switch viewModel.state {
        case .loaded(let products):
            ProductsGrid(products: products, navController: navController)
        case .loading:
            ProgressView()
        case .failed(let error):
            ErrorView(error: error)
        }
    }
}

private struct ProductsGrid: View {
    private let adaptiveColumn = [GridItem(.adaptive(minimum: 150))]
    let products: [Product]
    let navController: NavController
    
    var body: some View {
        if products.isEmpty {
            InfoView(title: "No Products", description: "Products will appear here")
        
        } else {
            LazyVGrid(columns: adaptiveColumn, spacing: 12) {
                ForEach(products, id: \.id) { product in
                    Button {
                        navController.navigate(to: .productInfo(productId: product.id))
                    } label: {
                        ProductItem(product: product)
                    }
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
    NavigationView {
        ProductsView(viewModel: ProductsViewModel(productsRepository: PreviewProductsRepository()))
            .environmentObject(NavController())
    }
}
