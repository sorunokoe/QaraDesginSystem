// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

@MainActor
public struct QaraButton: View {
    
    var text: String
    var foregroundColor: Color
    var backgroundColor: Color
    var stroke: (color: Color, width: CGFloat)?
    var font: Font
    var action: (() -> Void)
    
    public init(text: String,
                backgroundColor: Color,
                foregroundColor: Color,
                font: Font = .system(size: 16, weight: .medium),
                stroke: (Color, CGFloat)? = nil,
                action: @escaping () -> Void) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.font = font
        self.stroke = stroke
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(text)
                .font(font)
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
                   backgroundColor: .clear,
                   foregroundColor: .green,
                   stroke: (color: .green, width: 1),
                   action: {})
        QaraButton(text: "Continue",
                   backgroundColor: .green,
                   foregroundColor: .white,
                   action: {})
    }
}
