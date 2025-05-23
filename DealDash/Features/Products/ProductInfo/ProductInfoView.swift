//
//  ProductInfoView.swift
//  DealDash
//
//  Created by Daniel Waiguru on 25/03/2024.
//

import SwiftUI
import SwiftData

struct ProductInfoView: View {
    @ObservedObject private var viewModel: ProductInfoViewModel
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var navController: NavController
    let productId: Int
    init(productId: Int, viewModel: ProductInfoViewModel = DIContainer.shared.resolve()) {
        self.productId = productId
        self.viewModel = viewModel
    }
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            productInfoView
        }
        .navigationBarTitleDisplayMode(.inline)
        .disabled(viewModel.state == .loading)
        .alert(isPresented: $viewModel.hasError, error: viewModel.state.errorMessage) {}
        .task {
            await viewModel.getProductById(id: productId)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private var productInfoView: some View {
        switch viewModel.state {
        case .success(let data):
            ProductInfoViewInternal(data: data, modelContext: modelContext, navController: navController)
                .navigationTitle(data.title)
        case .loading,.empty:
            ProgressView()
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
                DealDashCurrencyText(price: data.price)
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
    ProductInfoView(productId: 1, viewModel: ProductInfoViewModel(productsRepository: PreviewProductsRepository()))
}
