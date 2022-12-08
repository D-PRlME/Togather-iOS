import SwiftUI

struct ContentTextEditor: View {
    @Binding var text: String
    let placeholder: String
    init(
        text: Binding<String>,
        placeholder: String
    ) {
        self._text = text
        self.placeholder = placeholder
        guard #available(iOS 16.0, *)
        else {
            UITextView.appearance().backgroundColor = .clear
            return
        }
    }
    var body: some View {
        if #available(iOS 16.0, *) {
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.whiteElevated4)
                        .padding(.leading, 5)
                        .padding(.top, 8)
                }
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .font(.title3m)
            .padding(8)
            .background(Color.whiteElevated1)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.whiteElevated3)
            )
            .multilineTextAlignment(.leading)
        } else {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                }
                TextEditor(text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .font(.title3m)
            .padding(8)
            .background(Color.whiteElevated1)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.whiteElevated3)
            )
            .multilineTextAlignment(.leading)
        }
    }
}

struct EditInfoTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        ContentTextEditor(text: .constant(""), placeholder: "자기소개")
    }
}
