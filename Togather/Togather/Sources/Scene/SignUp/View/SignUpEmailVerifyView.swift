import SwiftUI

struct EmailVerify: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    
    @StateObject var SignUpVM = SignUpViewModel()
    
    private func ButtonAtivation() -> Bool {
        if SignUpVM.code.count == 6 {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                NavigationLink(
                    destination:
                        signUpSuccess(
                            email: $email,
                            password: $password,
                            name: $name
                        ),
                    tag: 2,
                    selection: $SignUpVM.isSuccess
                ) { EmptyView() }
                
                
                VStack(alignment: .center, spacing: 12) {
                    Spacer()
                    
                    //MARK: - Title

                    EmailVerifyTitle(
                        email: email
                    )
                    
                    //MARK: - TextField

                    EmailVerifyTextField(
                        code: $SignUpVM.code
                    )
                    
                    //MARK: - Image

                    VStack(spacing: 0) {
                        Rectangle()
                            .frame(height: 50)
                            .opacity(0)
                        Image("PostBox")
                            .resizable()
                            .frame(width: 150, height: 150)
                    }
                    Spacer()
                        
                    //MARK: - Button

                    AuthButton(
                        text: "다음",
                        action: {
                            SignUpVM.emailVerify()
                        }
                    )
                } //Vstack
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .onAppear {
                    SignUpVM.email = email
                    SignUpVM.sendEmailToUser()
                }
                BackBtn()
            }
            .navigationBarHidden(true)
        }
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
