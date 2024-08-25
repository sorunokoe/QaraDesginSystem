//
//  OnboardingView.swift
//
//
//  Created by SALGARA, YESKENDIR on 13.03.24.
//

import SwiftUI

public struct OnboardingSlide {
    var contentView: () -> AnyView
    var title: String
    var description: String
    var buttonTitle: String

    public init(
        contentView: @escaping () -> AnyView,
        title: String,
        description: String,
        buttonTitle: String
    ) {
        self.contentView = contentView
        self.title = title
        self.description = description
        self.buttonTitle = buttonTitle
    }
}

public struct OnboardingView: View {
    var slides: [OnboardingSlide]

    var backgroundColor: Color
    var foregroundColor: Color
    var buttonBackgroundColor: Color
    var buttonColor: Color
    
    var onFinish: (() -> Void)

    @State private var hStackScrollPosition: Int? = 0
    
    public init(
        slides: [OnboardingSlide],
        backgroundColor: Color,
        foregroundColor: Color,
        buttonBackgroundColor: Color,
        buttonColor: Color,
        onFinish: @escaping (() -> Void)
    ) {
        self.slides = slides
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.buttonBackgroundColor = buttonBackgroundColor
        self.buttonColor = buttonColor
        self.onFinish = onFinish
    }

    public var body: some View {
        VStack(alignment: .center, spacing: 32) {
            if slides.count > 1 {
                HStack(alignment: .center, spacing: 4) {
                    ForEach(0 ..< slides.count, id: \.self) { i in
                        Circle()
                            .fill((i == (hStackScrollPosition ?? 0)) ? foregroundColor : foregroundColor.opacity(0.4))
                            .frame(width: 8, height: 8)
                    }
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(Array(slides.enumerated()), id: \.offset) { index, slide in
                        VStack(alignment: .center) {
                            slide.contentView()
                            VStack(alignment: .center, spacing: 16) {
                                Text(slide.title)
                                    .font(.system(size: 32, weight: .medium))
                                    .fixedSize(horizontal: false, vertical: true)
                                Text(slide.description)
                                    .font(.system(size: 18, weight: .regular))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .multilineTextAlignment(.center)
                            .foregroundColor(foregroundColor)
                        }
                        .padding(20)
                        .containerRelativeFrame(.horizontal)
                        .id(index)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
            .scrollClipDisabled()
            .scrollPosition(id: $hStackScrollPosition)

            QaraButton(
                text: slides[hStackScrollPosition ?? 0].buttonTitle,
                backgroundColor: buttonBackgroundColor,
                foregroundColor: buttonColor,
                font: .system(size: 18, weight: .medium),
                action: {
                    if (hStackScrollPosition ?? 0) < slides.count - 1 {
                        withAnimation {
                            hStackScrollPosition = (hStackScrollPosition ?? 0) + 1
                        }
                    } else {
                        onFinish()
                    }
                }
            )
            .padding(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
    }
}

#if DEBUG
#Preview {
    OnboardingView(
        slides: [
            .init(
                contentView: {
                    AnyView(Image(systemName: "basketball.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.white))
                },
                title: "Step 1",
                description: "1: Complete daily quest to increase your level and get powerful",
                buttonTitle: "Next"
            ),
            .init(
                contentView: {
                    AnyView(Image(systemName: "volleyball.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.white))
                },
                title: "Step 2",
                description: "2: Complete daily quest to increase your level and get powerful",
                buttonTitle: "Next"
            ),
            .init(
                contentView: {
                    AnyView(Image(systemName: "trophy.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.white))
                },
                title: "Step 3",
                description: "3: Complete daily quest to increase your level and get powerful",
                buttonTitle: "Complete"
            ),
        ],
        backgroundColor: .black,
        foregroundColor: .white,
        buttonBackgroundColor: .white,
        buttonColor: .black, 
        onFinish: {
            print("Did finish")
        }
    )
}
#endif
