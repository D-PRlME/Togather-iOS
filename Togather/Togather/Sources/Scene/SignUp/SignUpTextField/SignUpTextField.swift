import SwiftUI

struct SignUpTextField: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    @Binding var emailError: Bool
    @Binding var passwordError: Bool
    var body: some View {
        VStack(spacing: 12) {
            AuthTextField(
                placeholder: "이메일",
                text: $email,
                message: "dsm.hs.kr 도메인을 사용하는 이메일을 사용하세요",
                isError: $emailError
            )
            AuthTextField(
                placeholder: "비밀번호",
                isSecret: true,
                text: $password,
                message: "8자리 이상, 숫자, 영어 소문자, 특수문자를 포함해야 합니다 ",
                isError: $passwordError
            )
            AuthTextField(
                placeholder: "이름",
                text: $name
            )
        }
    }
}

struct SignUpTextField_Previews: PreviewProvider {
    static var previews: some View {
        SignUpTextField(
            email: .constant(""),
            password: .constant(""),
            name: .constant(""),
            emailError: .constant(false),
            passwordError: .constant(true)
        )
    }
}
