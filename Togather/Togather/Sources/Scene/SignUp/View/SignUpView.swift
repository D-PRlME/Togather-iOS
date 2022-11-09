import SwiftUI

struct SignUpView: View {
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @State private var nameText: String = ""
    
    @StateObject var signUpVM = SignUpViewModel()
    
    let signUpValueCheckVM = SignUpValueCheckViewModel()
    
    // MARK: - body
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination:
                    EmailVerify(
                        email: $emailText,
                        password: $passwordText,
                        name: $nameText
                    ),
                tag: 1,
                selection: $signUpVM.isSuccess
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
                    emailError: .constant(!signUpValueCheckVM.emailValueCheck(emailText)),
                    passwordError: .constant(!signUpValueCheckVM.passwordValueCheck(passwordText))
                )
                Spacer()
                
                // MARK: - 다음 버튼
                
                AuthButton(
                    isDisable: .constant(!signUpValueCheckVM.checkTotalSignUpValue(emailText, passwordText, nameText)),
                    text: "다음",
                    action: {
                        signUpVM.email = emailText
                        signUpVM.emailDuplicate()
                    }
                )
            } //Vstack
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            
            BackBtn()
        }
        .navigationBarHidden(true)
        
        .alert("안내", isPresented: $signUpVM.showError) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(signUpVM.errorMessage)
        }
    } //body
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
