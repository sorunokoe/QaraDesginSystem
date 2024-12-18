//
//  OnboardingView.swift
//
//
//  Created by SALGARA, YESKENDIR on 13.03.24.
//

import SwiftUI

public struct OnboardingSlide: Identifiable {
    public var id: UUID = UUID()
    var contentView: (() -> AnyView)?
    var title: String
    var description: String
    var prevButtonTitle: String
    var nextButtonTitle: String

    public init(
        contentView: (() -> AnyView)?,
        title: String,
        description: String,
        prevButtonTitle: String,
        nextButtonTitle: String
    ) {
        self.contentView = contentView
        self.title = title
        self.description = description
        self.prevButtonTitle = prevButtonTitle
        self.nextButtonTitle = nextButtonTitle
    }
}

@MainActor
public struct OnboardingView: View {
    var slides: [OnboardingSlide]

    var backgroundColor: Color
    var foregroundColor: Color
    var buttonBackgroundColor: Color
    var buttonColor: Color
    
    var onChange: ((Int) -> Void)?
    var onFinish: () -> Void

    @State private var hStackScrollPosition: Int? = 0
    
    public init(
        slides: [OnboardingSlide],
        backgroundColor: Color,
        foregroundColor: Color,
        buttonBackgroundColor: Color,
        buttonColor: Color,
        onChange: ((Int) -> Void)?,
        onFinish: @escaping (() -> Void)
    ) {
        self.slides = slides
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.buttonBackgroundColor = buttonBackgroundColor
        self.buttonColor = buttonColor
        self.onChange = onChange
        self.onFinish = onFinish
    }

    public var body: some View {
        ZStack {
            if slides.count > 1 {
                IndicatorView(currentIndex: (hStackScrollPosition ?? 0),
                              count: slides.count,
                              color: buttonBackgroundColor)
                .padding(.vertical, 16)
                .frame(maxHeight: .infinity, alignment: .top)
            }
            Spacer()
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(slides, id: \.id) { slide in
                        VStack(alignment: .center) {
                            if let contentView = slide.contentView {
                                contentView()
                            }
                            VStack(alignment: .center, spacing: 16) {
                                Text(slide.title)
                                    .font(.system(size: 30, weight: .medium))
                                    .fixedSize(horizontal: false, vertical: true)
                                Text(slide.description)
                                    .font(.system(size: 20, weight: .regular))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .multilineTextAlignment(.center)
                            .foregroundColor(foregroundColor)
                            .padding(20)
                        }
                        .containerRelativeFrame(.horizontal)
                        .id(slides.firstIndex { $0.id == slide.id })
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
            .scrollClipDisabled()
            .scrollPosition(id: $hStackScrollPosition)
            
            buttons
                .padding(.vertical, 16)
                .frame(maxHeight: .infinity, alignment: .bottom)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
        .animation(.easeInOut, value: hStackScrollPosition)
        .onChange(of: hStackScrollPosition) {
            withAnimation {
                onChange?(hStackScrollPosition ?? 0)
            }
        }
    }
    
    @ViewBuilder
    var buttons: some View {
        HStack(alignment: .center, spacing: 16) {
            if hStackScrollPosition != slides.count - 1 {
                QaraButton(
                    text: slides[hStackScrollPosition ?? 0].prevButtonTitle,
                    backgroundColor: .clear,
                    foregroundColor: buttonBackgroundColor,
                    font: .system(size: 18, weight: .medium),
                    stroke: (buttonBackgroundColor, 1),
                    height: 24,
                    action: {
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        onFinish()
                    }
                )
            }
            QaraButton(
                text: slides[hStackScrollPosition ?? 0].nextButtonTitle,
                backgroundColor: buttonBackgroundColor,
                foregroundColor: buttonColor,
                font: .system(size: 18, weight: .medium),
                height: 24,
                action: {
                    if (hStackScrollPosition ?? 0) < slides.count - 1 {
                        hStackScrollPosition = (hStackScrollPosition ?? 0) + 1
                    } else {
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        onFinish()
                    }
                }
            )
            .shadow(color: buttonBackgroundColor, radius: 2)
        }
        .padding(.horizontal, 20)
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
                        .foregroundStyle(.primary))
                },
                title: "Step 1",
                description: "1: Complete daily quest to increase your level and get powerful",
                prevButtonTitle: "Skip",
                nextButtonTitle: "Next"
            ),
            .init(
                contentView: {
                    AnyView(Image(systemName: "volleyball.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.primary))
                },
                title: "Step 2",
                description: "2: Complete daily quest to increase your level and get powerful",
                prevButtonTitle: "Skip",
                nextButtonTitle: "Next"
            ),
            .init(
                contentView: {
                    AnyView(Image(systemName: "trophy.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.primary))
                },
                title: "Step 3",
                description: "3: Complete daily quest to increase your level and get powerful",
                prevButtonTitle: "Skip",
                nextButtonTitle: "Complete"
            ),
        ],
        backgroundColor: .white,
        foregroundColor: .black,
        buttonBackgroundColor: .pink.opacity(0.8),
        buttonColor: .white,
        onChange: nil,
        onFinish: {
            print("Did finish")
        }
    )
}
#endif
