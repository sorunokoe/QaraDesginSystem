//
//  SwiftUIView.swift
//
//
//  Created by SALGARA, YESKENDIR on 12.03.24.
//

import SwiftUI

struct QaraProgressView: View {
    
    var progress: CGFloat
    var cornerRadius: CGFloat
    var background: Color
    var tint: Color
    
    var body: some View {
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

#Preview {
    QaraProgressView(progress: 0.8, cornerRadius: 16,
                 background: .gray, tint: .blue)
}
