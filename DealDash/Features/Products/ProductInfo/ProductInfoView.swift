//
//  ProductInfoView.swift
//  DealDash
//
//  Created by Daniel Waiguru on 25/03/2024.
//

import SwiftUI
import SwiftData

struct ProductInfoView: View {
    @StateObject var viewModel = ProductInfoViewModel()
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var navController: NavController
    let productId: Int
    var body: some View {
        ScrollView {
            productInfoView
        }
        .navigationBarTitleDisplayMode(.inline)
        .disabled(viewModel.state == .loading)
        .alert(isPresented: $viewModel.hasError, error: viewModel.state.errorMessage) {}
        .task {
            await viewModel.getProductById(id: productId)
        }
        .padding()
    }
    
    @ViewBuilder
    private var productInfoView: some View {
        switch viewModel.state {
        case .success(let data):
            ProductInfoViewInternal(data: data, modelContext: modelContext, navController: navController)
                .navigationTitle(data.title)
        case .loading,.empty:
            ProductsView()
        case .error(error: let error):
            ErrorView(error: error)
        }
    }
}
private struct ProductInfoViewInternal: View {
    let data: Product
    let modelContext: ModelContext
    let navController: NavController
    var body: some View {
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
                    navController.navigateBack()
                }
            }
        }
    }
}

#Preview {
    ProductInfoView(productId: 1)
}
