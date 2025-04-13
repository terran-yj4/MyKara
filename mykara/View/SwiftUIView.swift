import SwiftUI

struct TagInputView: View {
    @State private var currentInput = ""
    @State private var tempTags: [String] = []
    @State private var confirmedTags: [String] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // タグ表示エリア
            WrapHStack(tags: tempTags)
            
            // 入力フィールド
            TextField("タグを入力（スペースで区切り）", text: $currentInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: currentInput) { newValue in
                    if let lastChar = newValue.last, lastChar == " " {
                        let trimmed = newValue.trimmingCharacters(in: .whitespaces)
                        if !trimmed.isEmpty {
                            tempTags.append(trimmed)
                        }
                        currentInput = ""
                    }
                }
            
            // 配列に保存
            Button("タグを確定") {
                confirmedTags = tempTags
                tempTags.removeAll()
                print("タグ配列: \(confirmedTags)")
            }
            
            // 確認用
            Text("確定されたタグ: \(confirmedTags.joined(separator: ", "))")
                .padding(.top, 10)
        }
        .padding()
    }
}

// タグを丸く表示するカスタム View
struct WrapHStack: View {
    let tags: [String]
    
    var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                        .padding(4)
                        .alignmentGuide(.leading) { dimension in
                            if (abs(width - dimension.width) > geometry.size.width) {
                                width = 0
                                height -= dimension.height
                            }
                            let result = width
                            if tag == tags.last {
                                width = 0
                            } else {
                                width -= dimension.width
                            }
                            return result
                        }
                        .alignmentGuide(.top) { _ in
                            let result = height
                            if tag == tags.last {
                                height = 0
                            }
                            return result
                        }
                }
            }
        }
        .frame(height: 100) // 適宜調整
    }
}

#Preview(body: {
    TagInputView()
})
