import SwiftUI

struct PostTextEditor: View {
    @Binding var text: String
    var placeholder: String
    
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
            TextEditor(text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .scrollContentBackground(.hidden)
                .font(.title3m)
                .padding(.leading, 8)
                .background(Color.whiteElevated1)
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.whiteElevated3)
                )
                .multilineTextAlignment(.leading)
        } else {
            TextEditor(text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .font(.title3m)
                .padding(.leading, 8)
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

struct WritingTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        PostTextEditor(
            text: .constant("Hello!Word!Hello!Word!Hello!Word!Hello!Word!Hello!Word!Hello!Word!Hello!Word!Hello!Word!Hello!Word!Hello!Word!Hello!Word!Hello!Word!Hd"),
            placeholder: "안녕"
        )
    }
}
