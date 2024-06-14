//
//  WrappedWordHStack.swift
//  Alqissa
//
//  Created by SALGARA, YESKENDIR on 16.03.24.
//

#if canImport(UIKit)
import UIKit
import SwiftUI

public struct WrappedWordsHStack<Content: View>: View {
    
    private let words: [String]
    private let content: (String) -> Content
    
    private let spacing: CGFloat
    private let itemSpacing: CGFloat
    private let itemPadding: CGFloat
    private let fontSize: CGFloat
    
    public init(words: [String],
                content: @escaping (String) -> Content,
                spacing: CGFloat = 8,
                itemSpacing: CGFloat = 8,
                itemPadding: CGFloat = 8,
                fontSize: CGFloat = 18) {
        self.words = words
        self.content = content
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
                        content(word)
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
                               "everything", "all", "right", "good"]) { word in
        Text(word)
            .font(.system(size: 18))
            .padding(8)
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.blue)
            )
    }
}
#endif
