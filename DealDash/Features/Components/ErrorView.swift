//
//  ErrorView.swift
//  DealDash
//
//  Created by Daniel Waiguru on 12/05/2025.
//

import SwiftUI

struct ErrorView: View {
    var title: String = "Error"
    let error: DealDashError
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text(title)
                .fontWeight(.semibold)
            Text(error.errorDescription ?? error.localizedDescription)
            Spacer()
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    ErrorView(title: "", error: DealDashError.appError(error: "Some error desc"))
}
