import SwiftUI

struct EmailVerifyTextField: View {
    @Binding var code: String
    var body: some View {
        AuthTextField(
            placeholder: "인증 번호",
            text: $code
        )
    }
}

struct EmailVerifyTextField_Previews: PreviewProvider {
    static var previews: some View {
        EmailVerifyTextField(code: .constant(""))
    }
}
