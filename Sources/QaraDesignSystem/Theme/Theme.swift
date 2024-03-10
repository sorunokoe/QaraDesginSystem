//
//  File.swift
//  
//
//  Created by SALGARA, YESKENDIR on 10.03.24.
//

import SwiftUI

public class Theme {
    
    public static var shared: Theme!
    
    public struct QaraColors {
        var brandColor: Color
        var selectedColor: Color
        var successColor: Color
        var failureColor: Color
    }
    
    public var colors: QaraColors
    
    public static func createTheme(colors: QaraColors) {
        self.shared = Theme(colors: colors)
    }
    
    private init(colors: QaraColors) {
        self.colors = colors
    }
    
}
