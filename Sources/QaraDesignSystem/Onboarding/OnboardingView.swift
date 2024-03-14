//
//  OnboardingView.swift
//
//
//  Created by SALGARA, YESKENDIR on 13.03.24.
//

import SwiftUI

public struct OnboardingSlide {
    var image: Image
    var title: String
    var description: String
    var buttonTitle: String
    
    public init(image: Image,
                title: String,
                description: String,
                buttonTitle: String) {
        self.image = image
        self.title = title
        self.description = description
        self.buttonTitle = buttonTitle
    }
    
}

public struct OnboardingView: View {
    
    var slides: [OnboardingSlide] = []
    @State private var currentIndex: Int = 0
    
    var backgroundColor: Color
    var foregroundColor: Color
    var buttonColor: Color
    
    public init(slides: [OnboardingSlide],
                backgroundColor: Color,
                foregroundColor: Color,
                buttonColor: Color) {
        self.slides = slides
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.buttonColor = buttonColor
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 32) {
            if slides.count > 1 {
                HStack(alignment: .center, spacing: 4) {
                    ForEach(0..<slides.count, id: \.self) { i in
                        Circle()
                            .fill(i == currentIndex ? foregroundColor : buttonColor)
                            .frame(width: 8, height: 8)
                    }
                }
            }
            Spacer()
            slides[currentIndex].image
                .resizable()
                .frame(width: 150, height: 150)
            Spacer()
            Text(slides[currentIndex].title)
                .font(.system(size: 32, weight: .medium))
            Text(slides[currentIndex].description)
                .font(.system(size: 18, weight: .regular))
            Spacer()
            QaraButton(text: slides[currentIndex].buttonTitle,
                       action: {
                if currentIndex < slides.count-1 {
                    withAnimation {
                        currentIndex += 1
                    }
                }
            },
                       backgroundColor: foregroundColor,
                       foregroundColor: buttonColor)
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
    }
}

#Preview {
    OnboardingView(slides: [
        .init(image: Image(systemName: "basketball.circle.fill"),
              title: "Step 1",
              description: "1: Complete daily quest to increase your level and get powerful",
              buttonTitle: "Next"),
        .init(image: Image(systemName: "volleyball.circle.fill"),
              title: "Step 2",
              description: "2: Complete daily quest to increase your level and get powerful",
              buttonTitle: "Next"),
        .init(image: Image(systemName: "trophy.circle.fill"),
              title: "Step 3",
              description: "3: Complete daily quest to increase your level and get powerful",
              buttonTitle: "Complete")
    ],
                   backgroundColor: .green.opacity(0.4),
                   foregroundColor: .green.opacity(0.8),
                   buttonColor: .black)
}
