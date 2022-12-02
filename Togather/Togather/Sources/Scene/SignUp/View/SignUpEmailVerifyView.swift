import SwiftUI

struct SignUpEmailVerifyView: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    @StateObject var signUpEmailVerifyViewModel = SignUpEmailVerifyViewModel()
    var body: some View {
        BackgroundTapGesture {
            ZStack {
                NavigationLink(
                    destination:
                        SignUpSuccessView(
                            email: $email,
                            password: $password,
                            name: $name
                        ),
                    tag: 2,
                    selection: $signUpEmailVerifyViewModel.isSuccess
                ) { EmptyView() }
                VStack(alignment: .center, spacing: 12) {
                    Spacer()
                    // MARK: - Title
                    EmailVerifyTitle(
                        email: email,
                        second: $signUpEmailVerifyViewModel.timer
                    )
                    // MARK: - TextField
                    EmailVerifyTextField(
                        code: $signUpEmailVerifyViewModel.code
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
                            signUpEmailVerifyViewModel.emailVerify()
                        }
                    )
                } // Vstack
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .onAppear {
                    signUpEmailVerifyViewModel.email = email
                    signUpEmailVerifyViewModel.sendEmailToUser()
                }
                BackBtn()
            }
            .navigationBarHidden(true)
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct EmailVerify_Previews: PreviewProvider {
    static var previews: some View {
        SignUpEmailVerifyView(
            email: .constant("bj"),
            password: .constant("dd"),
            name: .constant("조병진")
        )
    }
}
