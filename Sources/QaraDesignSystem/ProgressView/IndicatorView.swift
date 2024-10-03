//
//  SwiftUIView.swift
//  
//
//  Created by SALGARA, YESKENDIR on 03.10.24.
//

import SwiftUI

public struct IndicatorView: View {
    let currentIndex: Int
    let count: Int
    let color: Color
    
    public init(currentIndex: Int, count: Int, color: Color) {
        self.currentIndex = currentIndex
        self.count = count
        self.color = color
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 4) {
            ForEach(0 ..< count, id: \.self) { i in
                if (i == currentIndex) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(color)
                        .frame(width: 16, height: 8)
                } else {
                    Circle()
                        .fill(color.opacity(0.4))
                        .frame(width: 8, height: 8)
                }
            }
        }
    }
}

#Preview {
    IndicatorView(currentIndex: 0,
                  count: 8,
                  color: .black)
}
