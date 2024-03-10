// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

@MainActor
public struct QaraButton: View {
    
    var text: String
    var action: (() -> Void)
    var backgroundColor: Color
    
    public var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(text)
                .frame(maxWidth: .infinity)
                .padding(16)
                .foregroundStyle(.white)
                .background(backgroundColor)
                .clipShape(.rect(cornerSize: CGSize(width: 16, height: 16)))
        })
    }
    
}
