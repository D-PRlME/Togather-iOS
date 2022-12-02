import SwiftUI

struct SignUpView: View {
    @StateObject var signUpViewModel = SignUpViewModel()
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @State private var nameText: String = ""
    // MARK: - body
    var body: some View {
        BackgroundTapGesture {
            ZStack {
                NavigationLink(
                    destination:
                        SignUpEmailVerifyView(
                            email: $emailText,
                            password: $passwordText,
                            name: $nameText
                        ),
                    tag: 1,
                    selection: $signUpViewModel.isSuccess
                ) { EmptyView() }
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    SignUpTitle()
                        .padding(.bottom, 50)
                    // MARK: - textFileds
                    SignUpTextField(
                        email: $emailText,
                        password: $passwordText,
                        name: $nameText,
                        emailError: .constant(!signUpViewModel.emailValueCheck(emailText)),
                        passwordError: .constant(!signUpViewModel.passwordValueCheck(passwordText))
                    )
                    Spacer()
                    // MARK: - 다음 버튼
                    AuthButton(
                        isDisable: .constant(!signUpViewModel.checkTotalSignUpValue(emailText, passwordText, nameText)),
                        text: "다음",
                        action: {
                            signUpViewModel.email = emailText
                            signUpViewModel.emailDuplicate()
                        }
                    )
                } // Vstack
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                BackBtn()
            }
            .navigationBarHidden(true)
            .alert("안내", isPresented: $signUpViewModel.showError) {
                Button("확인", role: .cancel) { }
            } message: {
                Text(signUpViewModel.errorMessage)
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    } // body
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
