//
//  SwiftUIView.swift
//
//
//  Created by SALGARA, YESKENDIR on 12.03.24.
//

import SwiftUI

public struct QaraProgressView: View {
    
    var progress: CGFloat
    var cornerRadius: CGFloat
    var background: Color
    var tint: Color
    
    public init(progress: CGFloat, cornerRadius: CGFloat, background: Color, tint: Color) {
        self.progress = progress
        self.cornerRadius = cornerRadius
        self.background = background
        self.tint = tint
    }
    
    public var body: some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(background)
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(tint)
                        .frame(width: geo.size.width * progress)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
        }
    }
}

#if DEBUG
#Preview {
    QaraProgressView(progress: 0.8, cornerRadius: 16,
                 background: .gray, tint: .blue)
}
#endif
