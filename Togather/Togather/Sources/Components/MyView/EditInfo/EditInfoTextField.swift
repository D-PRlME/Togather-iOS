import SwiftUI

struct EditInfoTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .font(.title3m)
            .padding(12)
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

struct EditInfoTextField_Previews: PreviewProvider {
    static var previews: some View {
        EditInfoTextField(
            placeholder: "제목",
            text: .constant("")
        )
    }
}
