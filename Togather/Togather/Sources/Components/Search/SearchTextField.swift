import SwiftUI

struct SearchTextField: View {
    let placeholder: String
    @Binding var text: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .font(.title3m)
                .multilineTextAlignment(.leading)
            
            Image("SearchOff")
                .resizable()
                .frame(width: 28, height: 28)
                .onTapGesture {
                    action()
                }
        }
        .padding(12)
        .background(Color.whiteElevated1)
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(lineWidth: 1)
                .foregroundColor(.whiteElevated3)
        )
    }
}

struct SearchTextField_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextField(
            placeholder: "검색",
            text: .constant(""),
            action: { }
        )
    }
}
