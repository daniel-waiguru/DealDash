//
//  SettingsView.swift
//  DealDash
//
//  Created by Daniel Waiguru on 05/04/2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section("General") {
                Text("One")
                Text("Two")
            }
        }
        .navigationTitle("Settings")
        .toolbarRole(.editor)
    }
}

#Preview {
    SettingsView()
}
