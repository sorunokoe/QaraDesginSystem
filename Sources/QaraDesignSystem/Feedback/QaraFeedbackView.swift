//
//  SwiftUIView.swift
//
//
//  Created by SALGARA, YESKENDIR on 08.06.24.
//

import SwiftUI

enum QaraFeedbackItemType: String {
    case raiting, features, textfield

    var title: String {
        switch self {
        case .raiting:
            return "Your Raiting"
        case .features:
            return "What can we improve"
        case .textfield:
            return "Your Feedback"
        }
    }
}

struct QaraFeedbackData: Equatable {
    let id: UUID = .init()
    let type: QaraFeedbackItemType
    let isRequired: Bool
    let options: [String]?
    var answer: String?

    init(
        type: QaraFeedbackItemType,
        isRequired: Bool = true,
        options: [String]? = nil,
        answer: String? = nil
    ) {
        self.type = type
        self.isRequired = isRequired
        self.options = options
        self.answer = answer
    }
}

struct QaraFeedbackStyle {
    let backgroundColor: Color
    let foregroundColor: Color
}

struct QaraFeedbackView: View {
    let title: String = "Add feedback"
    let subtitle: String = "Your feedback is valuable for us, feel free share."
    let thanks: String = "Thank you for the feedback!"
    @State var items: [QaraFeedbackData]
    let style: QaraFeedbackStyle
    let onSelected: ([QaraFeedbackData]) -> Void

    @State private var textFieldValue: String = ""
    @State private var stepItems: Int = 0
    @State private var seenItems: [UUID] = []
    @State private var isSent: Bool = false

    var body: some View {
        GeometryReader { _ in

            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 32) {
                    if isSent {
                        VStack(alignment: .center, spacing: 4) {
                            Text("👾")
                                .font(.system(size: 64, weight: .medium))
                            Text(thanks)
                                .font(.system(size: 20, weight: .medium))
                        }
                        .foregroundStyle(style.foregroundColor)
                        .frame(maxWidth: .infinity)
                    } else {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(title)
                                .font(.system(size: 24, weight: .medium))
                            Text(subtitle)
                                .font(.system(size: 18, weight: .medium))
                                .opacity(0.8)
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundStyle(style.foregroundColor)
                        Spacer()
                        VStack(alignment: .leading, spacing: 32) {
                            ForEach(Array(items[0 ... stepItems]), id: \.id) { item in
                                switch item.type {
                                case .raiting:
                                    QaraFeedbackRaitingView(item: item, style: style) {
                                        next(item, answer: $0)
                                    }
                                case .features:
                                    QaraFeedbackOptionsView(item: item, style: style) {
                                        next(item, answer: $0)
                                    }
                                case .textfield:
                                    QaraFeedbackItemView(title: "Your Feedback (Optional)") {
                                        TextEditor(text: $textFieldValue)
                                            .padding(8)
                                            .frame(height: 100)
                                            .background(style.foregroundColor)
                                            .foregroundStyle(style.backgroundColor)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                }
                            }
                        }
                        Spacer()
                        if stepItems == items.count - 1, isReadyToSubmit() {
                            QaraButton(
                                text: "Submit",
                                backgroundColor: style.foregroundColor,
                                foregroundColor: style.backgroundColor
                            ) {
                                submit()
                            }
                        }
                    }
                }
                .frame(minHeight: UIScreen.main.bounds.height / 1.2)
                .padding(.horizontal, 20)
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .foregroundStyle(style.foregroundColor)
        .background(style.backgroundColor)
    }

    private func next(_ item: QaraFeedbackData, answer: String?) {
        if let index = items.firstIndex(where: { $0 == item }) {
            items[index].answer = answer
        }
        if stepItems + 1 < items.count, !seenItems.contains(where: { $0 == item.id }) {
            seenItems.append(item.id)
            withAnimation {
                stepItems += 1
            }
            if !items[stepItems].isRequired {
                next(items[stepItems], answer: nil)
            }
        }
    }

    private func isReadyToSubmit() -> Bool {
        var isReady = true
        items.forEach { item in
            if item.isRequired {
                isReady = item.answer != nil
            }
        }
        return isReady
    }
    
    private func submit() {
        withAnimation {
            isSent = true
        }
        onSelected(items)
    }
}

struct QaraFeedbackItemView<Content: View>: View {
    let title: String
    let content: () -> Content

    init(title: String, content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    @ViewBuilder
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.system(size: 18, weight: .medium))
            content()
        }
    }
}

struct QaraFeedbackRaitingView: View {
    @State private var selectedValue: String?

    let item: QaraFeedbackData
    let style: QaraFeedbackStyle
    let onSelected: (String) -> Void

    @ViewBuilder
    var body: some View {
        QaraFeedbackItemView(title: item.type.title) {
            HStack(alignment: .center, spacing: 16) {
                ForEach(item.options ?? [], id: \.self) { option in
                    Button(action: {
                        selectedValue = option
                    }, label: {
                        Text(option)
                            .font(.system(size: 40))
                            .opacity(selectedValue == option ? 1 : 0.5)
                    })
                }
            }
            .frame(maxWidth: .infinity)
        }
        .onChange(of: selectedValue) { _, newValue in
            if let newValue {
                onSelected(newValue)
            }
        }
    }
}

struct QaraFeedbackOptionsView: View {
    @State private var selectedValue: String?

    let item: QaraFeedbackData
    let style: QaraFeedbackStyle
    let onSelected: (String) -> Void

    @ViewBuilder
    var body: some View {
        QaraFeedbackItemView(title: item.type.title) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140, maximum: 300))], alignment: .leading, spacing: 16) {
                ForEach(item.options ?? [], id: \.self) { option in
                    Button(action: {
                        selectedValue = option
                    }, label: {
                        Text(option)
                            .font(.system(size: 18))
                            .foregroundStyle(style.foregroundColor.opacity(0.8))
                            .opacity(selectedValue == option ? 1 : 0.5)
                    })
                    .padding(8)
                    .background(style.foregroundColor.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
        .onChange(of: selectedValue) { _, newValue in
            if let newValue {
                onSelected(newValue)
            }
        }
    }
}

#Preview {
    QaraFeedbackView(
        items: [
            QaraFeedbackData(type: .raiting, options: ["🤩", "☺️", "🙂", "😔", "😭"]),
            QaraFeedbackData(type: .features, options: [
                "🧘🏻 Meditation",
                "😶 Emotion tracker",
                "😮‍💨 Breathing",
                "🤯 Anxiety tracker",
                "📈 Reports",
            ]),
            QaraFeedbackData(type: .textfield, isRequired: false),
        ], style: .init(
            backgroundColor: .black,
            foregroundColor: .white
        )
    ) { result in
        print(result)
    }
}
