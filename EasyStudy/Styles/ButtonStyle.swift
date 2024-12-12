//
//  ButtonStyle.swift
//  EasyStudy
//
//  Created by Vladimir Kremnev on 12/12/2024.
//

import SwiftUI

struct GlobalButtonStyle: ButtonStyle {
    let backgroundColor: Color
    let foregroundColor: Color
    let cornerRadius: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Add press effect
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
