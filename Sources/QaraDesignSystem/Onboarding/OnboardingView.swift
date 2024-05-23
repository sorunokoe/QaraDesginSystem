//
//  OnboardingView.swift
//
//
//  Created by SALGARA, YESKENDIR on 13.03.24.
//

import SwiftUI

public struct OnboardingSlide {
    var blockView: AnyView
    var title: String
    var description: String
    var buttonTitle: String

    public init(
        blockView: AnyView,
        title: String,
        description: String,
        buttonTitle: String
    ) {
        self.blockView = blockView
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
    var buttonBackgroundColor: Color
    var buttonColor: Color

    public init(
        slides: [OnboardingSlide],
        backgroundColor: Color,
        foregroundColor: Color,
        buttonBackgroundColor: Color,
        buttonColor: Color
    ) {
        self.slides = slides
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.buttonBackgroundColor = buttonBackgroundColor
        self.buttonColor = buttonColor
    }

    public var body: some View {
        VStack(alignment: .center, spacing: 32) {
            if slides.count > 1 {
                HStack(alignment: .center, spacing: 4) {
                    ForEach(0 ..< slides.count, id: \.self) { i in
                        Circle()
                            .fill(i == currentIndex ? foregroundColor : foregroundColor.opacity(0.4))
                            .frame(width: 8, height: 8)
                    }
                }
            }
            Spacer()
            slides[currentIndex].blockView
            Spacer()
            VStack(alignment: .center, spacing: 16) {
                Text(slides[currentIndex].title)
                    .font(.system(size: 32, weight: .medium))
                Text(slides[currentIndex].description)
                    .font(.system(size: 18, weight: .regular))
            }
            .multilineTextAlignment(.center)
            .foregroundColor(foregroundColor)
            Spacer()
            QaraButton(
                text: slides[currentIndex].buttonTitle,
                backgroundColor: buttonBackgroundColor,
                foregroundColor: buttonColor,
                font: .system(size: 18, weight: .medium),
                action: {
                    if currentIndex < slides.count - 1 {
                        withAnimation {
                            currentIndex += 1
                        }
                    }
                }
            )
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
    }
}

#Preview {
    OnboardingView(
        slides: [
            .init(
                blockView: AnyView(Image(systemName: "basketball.circle.fill").resizable().foregroundStyle(.white)),
                title: "Step 1",
                description: "1: Complete daily quest to increase your level and get powerful",
                buttonTitle: "Next"
            ),
            .init(
                blockView: AnyView(Image(systemName: "volleyball.circle.fill").resizable().foregroundStyle(.white)),
                title: "Step 2",
                description: "2: Complete daily quest to increase your level and get powerful",
                buttonTitle: "Next"
            ),
            .init(
                blockView: AnyView(Image(systemName: "trophy.circle.fill").resizable().foregroundStyle(.white)),
                title: "Step 3",
                description: "3: Complete daily quest to increase your level and get powerful",
                buttonTitle: "Complete"
            ),
        ],
        backgroundColor: .black,
        foregroundColor: .white,
        buttonBackgroundColor: .white,
        buttonColor: .black
    )
}
