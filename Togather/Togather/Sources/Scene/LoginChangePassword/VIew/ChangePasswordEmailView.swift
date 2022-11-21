import SwiftUI

struct ChangePasswordEmailView: View {
    @StateObject var changePasswordEmailViewModel = ChangePasswordEmailViewModel()
    private func buttonAtivation() -> Bool {
        if changePasswordEmailViewModel.myEmail.contains("@dsm.hs.kr") {
            return false
        } else {
            return true
        }
    }
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                NavigationLink(destination: EmailVerifyView(email: changePasswordEmailViewModel.myEmail), tag: 1, selection: $changePasswordEmailViewModel.goEnterPW) { EmptyView() }
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                        .frame(height: proxy.size.height / 5)
                    ChangePasswordTitle(
                        title: "비밀번호 변경",
                        subTitle: "인증번호를 받기 위한 이메일 주소가 필요합니다"
                    )
                    ChangePasswordTextField(
                        placeholder: "이메일",
                        keybordType: .emailAddress,
                        text: $changePasswordEmailViewModel.myEmail,
                        isError: $changePasswordEmailViewModel.isError,
                        indicatorMassage: $changePasswordEmailViewModel.errorMessage
                    )
                    Spacer()
                    AuthButton(
                        isDisable: .constant(buttonAtivation()),
                        text: "다음",
                        action: {
                            changePasswordEmailViewModel.sendChangePWEmail()
                        }
                    )
                    .padding(.bottom, proxy.safeAreaInsets.bottom == 0 ? 30 : 5)
                } // Vstack
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .navigationBarHidden(true)
            BackBtn()
        }
    }
}

struct ChangePasswordEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordEmailView()
    }
}
