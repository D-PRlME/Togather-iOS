import SwiftUI

struct EmailVerify: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    
    @StateObject var signUpVM = SignUpViewModel()
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination:
                    SignUpSuccess(
                        email: $email,
                        password: $password,
                        name: $name
                    ),
                tag: 2,
                selection: $signUpVM.isSuccess
            ) { EmptyView() }
            
            
            VStack(alignment: .center, spacing: 12) {
                Spacer()
                
                // MARK: - Title
                
                EmailVerifyTitle(
                    email: email
                )
                
                // MARK: - TextField
                
                EmailVerifyTextField(
                    code: $signUpVM.code
                )
                
                // MARK: - Image
                
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 50)
                        .opacity(0)
                    Image("PostBox")
                        .resizable()
                        .frame(width: 150, height: 150)
                }
                Spacer()
                
                // MARK: - Button
                
                AuthButton(
                    text: "다음",
                    action: {
                        signUpVM.emailVerify()
                    }
                )
            } //Vstack
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            .onAppear {
                signUpVM.email = email
                signUpVM.sendEmailToUser()
            }
            BackBtn()
        }
        .navigationBarHidden(true)
    }
}

struct EmailVerify_Previews: PreviewProvider {
    static var previews: some View {
        EmailVerify(
            email: .constant("bj"),
            password: .constant("dd"),
            name: .constant("조병진")
        )
    }
}
