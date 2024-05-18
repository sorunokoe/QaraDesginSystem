//
//  File.swift
//  
//
//  Created by SALGARA, YESKENDIR on 18.05.24.
//

import SwiftUI
import UIKit

extension View {
    @available(iOS 14, *)
    public func navigationBar(_ titleColor: Color, backgroundColor: Color) -> some View {
        let uiColor = UIColor(titleColor)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().setBackgroundImage(UIColor(backgroundColor).image(), for: .default)
        UINavigationBar.appearance().isTranslucent = true
        return self
    }
}
