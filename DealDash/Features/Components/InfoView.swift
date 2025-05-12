//
//  InfoView.swift
//  DealDash
//
//  Created by Daniel Waiguru on 12/05/2025.
//

import SwiftUI

struct InfoView: View {
    var title: String? = nil
    let description: String
    var body: some View {
        VStack {
            Spacer()
            if let infoTitle = title {
                Text(infoTitle)
                    .fontWeight(.bold)
            }
            Text(description)
            Spacer()
        }
    }
}

#Preview {
    InfoView(title: "Info", description: "No products found")
}
