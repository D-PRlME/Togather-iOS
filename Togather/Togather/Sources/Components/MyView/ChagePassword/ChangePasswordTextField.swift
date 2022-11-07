import SwiftUI

struct ChangePasswordTextField: View {
    var placeholder: String
    var keybordType: UIKeyboardType
    @Binding var text: String
    @Binding var isError: Bool
    @Binding var indicatorMassage: String
    
    init(
        placeholder: String,
        keybordType: UIKeyboardType,
        text: Binding<String>,
        isError: Binding<Bool> = .constant(false),
        indicatorMassage: Binding<String> = .constant("")
    ) {
        self.placeholder = placeholder
        self.keybordType = keybordType
        self._text = text
        self._isError = isError
        self._indicatorMassage = indicatorMassage
    }
    var body: some View {
        VStack {
            HStack {
                TextField(placeholder, text: $text)
                    .keyboardType(keybordType)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(.title3m)
                    .padding(.leading, 10)
            }
            .frame(height: 48)
            .background(Color.whiteElevated1)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: .init(lineWidth: 1))
                    .foregroundColor(isError ? .error : .whiteElevated3)
            )
            if isError {
                HStack {
                    Text(indicatorMassage)
                        .font(.indicator)
                        .foregroundColor(.error)
                        .padding(.leading, 12)
                    Spacer()
                }
            }
        }
    }
}

struct ChangePasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordTextField(
            placeholder: "비밀번호",
            keybordType: .emailAddress,
            text: .constant(""),
            isError: .constant(true),
            indicatorMassage: .constant("오류이다.")
        )
    }
}
