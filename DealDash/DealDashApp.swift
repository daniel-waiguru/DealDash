//
//  DealDashApp.swift
//  DealDash
//
//  Created by Daniel Waiguru on 18/02/2024.
//

import SwiftUI
import SwiftData
import netfox
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if DEBUG
        NFX.sharedInstance().start()
        #endif
        return true
    }
}
@main
struct DealDashApp: App {
    @StateObject var sessionHandler: SessionHandler = SessionHandler()
    @StateObject var navController: NavController = NavController()
    
    init() {
        registerDependencyGraph()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(
                path: $navController.path,
                root: {
                    startDestination
                    .environmentObject(sessionHandler)
                    .environmentObject(navController)
                    .navigationDestination(for: DealDashNavDestination.self) { navDestination in
                        navDestination
                            .environmentObject(sessionHandler)
                            .environmentObject(navController)
                    }
                    .preferredColorScheme(.light)
                }
            )
        }
        .modelContainer(for: CartProduct.self)
    }
    
    @ViewBuilder
    private var startDestination: some View {
        switch sessionHandler.session {
        case .loggedIn(_):
            ProductsView()
        case .loggedOut:
            SignInView()
        }
    }
    
    private func registerDependencyGraph() {
        let container = DIContainer.shared
        let authRepository: AuthRepository = AuthRepositoryImpl()
        let productsRepository: ProductsRepository = ProductsRepositoryImpl()
        container.register(authRepository)
        container.register(productsRepository)
        container.register(SignInViewModel(authRepository: container.resolve()))
        container.register(ProductsViewModel(productsRepository: container.resolve()))
        container.register(ProductInfoViewModel(productsRepository: container.resolve()))
    }
}
