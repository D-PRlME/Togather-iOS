import SwiftUI

struct TitleTextField: View {
    let placeholder: String
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.whiteElevated4)
            }
            TextField(placeholder, text: $text)
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

struct WritingTextField_Previews: PreviewProvider {
    static var previews: some View {
        TitleTextField(
            placeholder: "제목",
            text: .constant("")
        )
    }
}
