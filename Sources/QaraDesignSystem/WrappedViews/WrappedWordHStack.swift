//
//  WrappedWordHStack.swift
//  Alqissa
//
//  Created by SALGARA, YESKENDIR on 16.03.24.
//

import UIKit
import SwiftUI

public struct WrappedWordsHStack: View {
    
    private var words: [String]
    private var onTap: (String) -> Void
    
    private var foregroundColor: Color
    private var backgroundColor: Color
    
    private var spacing: CGFloat = 8
    private var itemSpacing: CGFloat = 8
    private var itemPadding: CGFloat = 8
    private var fontSize: CGFloat = 18
    
    public init(words: [String], 
                onTap: @escaping (String) -> Void,
                foregroundColor: Color,
                backgroundColor: Color,
                spacing: CGFloat = 8,
                itemSpacing: CGFloat = 8,
                itemPadding: CGFloat = 8,
                fontSize: CGFloat = 18) {
        self.words = words
        self.onTap = onTap
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.spacing = spacing
        self.itemSpacing = itemSpacing
        self.itemPadding = itemPadding
        self.fontSize = fontSize
    }
    
    @ViewBuilder
    public var body: some View {
        VStack(alignment: .center, spacing: spacing) {
            ForEach(getRows(words: words), id: \.self) { row in
                HStack(alignment: .center, spacing: itemSpacing) {
                    ForEach(row, id: \.self) { word in
                        Text(word)
                            .font(.system(size: fontSize))
                            .padding(itemPadding)
                            .foregroundStyle(foregroundColor)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(backgroundColor)
                            )
                            .onTapGesture {
                                onTap(word)
                            }
                    }
                }
            }
        }
    }
    
    private func getRows(words: [String]) -> [[String]] {
        var group: [[String]] = []
        var rowItems: [String] = []
        var width: CGFloat = 0
        
        for word in words {
            let label = UILabel()
            label.font = .systemFont(ofSize: fontSize)
            label.text = word
            label.sizeToFit()
            
            let labelWidth = label.frame.width + 32
            
            if (width + labelWidth + 32) < UIScreen.main.bounds.width {
                width += labelWidth
                rowItems.append(word)
            } else {
                width = labelWidth
                group.append(rowItems)
                rowItems.removeAll()
                rowItems.append(word)
            }
        }
        
        if !rowItems.isEmpty {
            group.append(rowItems)
        }

        return group
    }
    
}

#Preview {
    WrappedWordsHStack(words: ["hey", "how", "are", "you", "doing",
                               "everything", "all", "right", "good"],
                       onTap: { _ in },
                       foregroundColor: .white,
                       backgroundColor: .blue)
}
