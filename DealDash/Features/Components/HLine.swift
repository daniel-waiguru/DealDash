//
//  Line.swift
//  DealDash
//
//  Created by Daniel Waiguru on 08/06/2024.
//

import Foundation
import SwiftUI

struct HLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
