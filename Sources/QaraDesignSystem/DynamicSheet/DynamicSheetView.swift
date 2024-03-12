//
//  DynamicSheetView.swift
//
//
//  Created by SALGARA, YESKENDIR on 12.03.24.
//

import SwiftUI

@MainActor
public struct DynamicSheetView<Content: View>: View {
    
    var content: () -> Content
    
    @Binding var sheetContentHeight: CGFloat
    
    public init(content: @escaping () -> Content, sheetContentHeight: Binding<CGFloat>) {
        self.content = content
        self._sheetContentHeight = sheetContentHeight
    }
    
    @ViewBuilder
    public var body: some View {
        VStack {
            content()
        }
        .background {
            GeometryReader { proxy in
                Color.clear
                    .task {
                        sheetContentHeight = proxy.size.height
                    }
            }
        }
    }
    
}

#if DEBUG
#Preview {
    DynamicSheetView(content: { Color.red }, sheetContentHeight: .constant(200))
}
#endif
