//
//  File.swift
//  
//
//  Created by SALGARA, YESKENDIR on 10.03.24.
//

import SwiftUI

class Theme {
    
    static var shared: Theme!
    
    struct QaraColors {
        var brandColor: Color
        var selectedColor: Color
        var successColor: Color
        var failureColor: Color
    }
    
    var colors: QaraColors
    
    static func createTheme(colors: QaraColors) {
        self.shared = Theme(colors: colors)
    }
    
    private init(colors: QaraColors) {
        self.colors = colors
    }
    
}
