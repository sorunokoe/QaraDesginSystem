// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

@MainActor
public struct QaraButton: View {
    
    var text: String
    var action: (() -> Void)
    var foregroundColor: Color
    var backgroundColor: Color
    var stroke: (color: Color, width: CGFloat)?
    
    public init(text: String,
                action: @escaping () -> Void,
                backgroundColor: Color,
                foregroundColor: Color,
                stroke: (Color, CGFloat)? = nil) {
        self.text = text
        self.action = action
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.stroke = stroke
    }
    
    public var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(text)
                .frame(maxWidth: .infinity)
                .padding(16)
                .foregroundStyle(foregroundColor)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(backgroundColor)
                        .stroke(stroke?.color ?? .clear,
                                lineWidth: stroke?.width ?? 0)
                )
            
            
        })
    }
    
}

#Preview {
    VStack {
        QaraButton(text: "Continue",
                   action: {},
                   backgroundColor: .clear,
                   foregroundColor: .green,
                   stroke: (color: .green, width: 1))
        QaraButton(text: "Continue",
                   action: {},
                   backgroundColor: .green,
                   foregroundColor: .white)
    }
}
