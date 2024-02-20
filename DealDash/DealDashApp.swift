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
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SignInView()
                    .environmentObject(sessionHandler)
            }
        }
    }
}
