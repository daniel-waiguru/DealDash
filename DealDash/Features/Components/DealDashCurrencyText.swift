//
//  DealDashCurrencyView.swift
//  DealDash
//
//  Created by Daniel Waiguru on 12/05/2025.
//

import SwiftUI

struct DealDashCurrencyText: View {
    let price: Double
    var body: some View {
        Text(
            price,
            format: .currency(code: Locale.current.currency?.identifier ?? "USD").precision(.fractionLength(2))
        )
    }
}

#Preview {
    DealDashCurrencyText(price: 34.5)
}
