import SwiftUI

struct ChangePasswordVerifyView: View {
    @StateObject var changePasswordVerifyViewModel = ChangePasswordVerifyViewModel()
    private func buttonAtivation() -> Bool {
        if changePasswordVerifyViewModel.authCode.count == 6 {
            return true
        } else {
            return false
        }
    }
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                NavigationLink(destination: EnterNewPasswordView(), tag: 1, selection: $changePasswordVerifyViewModel.goEnterPW) { EmptyView() }
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                        .frame(height: 130)
                    ChangePasswordTitle(
                        title: "비밀번호 번경",
                        subTitle: "계정에 입력된 이메일로 전송된 6자리 인증 번호를 입력해 주세요.\n인증 번호는 \(changePasswordVerifyViewModel.timer)초 후에 만료됩니다"
                    )
                    ChangePasswordTextField(
                        placeholder: "인증 번호",
                        keybordType: .numberPad,
                        text: $changePasswordVerifyViewModel.authCode,
                        isError: $changePasswordVerifyViewModel.isError,
                        indicatorMassage: $changePasswordVerifyViewModel.errorMessage
                    )
                    GeometryReader { imageProxy in
                        Image("PostBox")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .position(x: imageProxy.size.width / 2, y: imageProxy.frame(in: .local).midY / 1.3)
                            .opacity(imageProxy.size.height > 170 ? 1 : 0)
                    }
                    ChangePasswordButton(
                        isDisable: .constant(!buttonAtivation()),
                        title: "다음",
                        action: {
                            changePasswordVerifyViewModel.emailVerify()
                        }
                    )
                    .padding(.bottom, proxy.safeAreaInsets.bottom == 0 ? 30 : 5)
                } // Vstack
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .navigationBarHidden(true)
            .onAppear {
                changePasswordVerifyViewModel.getMyProfile()
            }
            BackBtn()
        }
    }
}

struct ChangePasswordVerify_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordVerifyView()
    }
}
