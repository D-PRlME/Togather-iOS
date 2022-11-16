import SwiftUI

struct EnterNewPassword: View {
    @StateObject var changePWToEmailVM = ChangePasswordToEmailViewModel()
    var body: some View {
        GeometryReader { proxy in
            NavigationLink(destination: ChangePasswordSuccess(), tag: 1, selection: $changePWToEmailVM.goSucced) { EmptyView() }
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                    .frame(height: proxy.size.height / 6)
                ChangePasswordTitle(
                    title: "비밀번호 변경",
                    subTitle: "바꿀 새 비밀번호를 입력해 주세요"
                )
                VStack {
                    AuthTextField(
                        placeholder: "비밀번호",
                        isSecret: true,
                        text: $changePWToEmailVM.newPassword,
                        message: changePWToEmailVM.errorMessage,
                        isError: $changePWToEmailVM.isError
                    )
                    if !changePWToEmailVM.isError {
                        HStack {
                            Text("8자리 이상, 숫자, 영어 소문자, 특수문자를 포함해야 합니다")
                                .font(.indicator)
                                .foregroundColor(.whiteElevated4)
                                .padding(.leading, 12)
                            Spacer()
                        }
                    }
                }
                Spacer()
                ChangePasswordButton(
                    isDisable: .constant(!changePWToEmailVM.passwordValueCheck()),
                    title: "다음",
                    action: {
                        changePWToEmailVM.changePassword()
                    }
                )
                .padding(.bottom, proxy.safeAreaInsets.bottom == 0 ? 30 : 5)
            } // Vstack
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .navigationBarHidden(true)
    }
}

struct EnterNewPassword_Previews: PreviewProvider {
    static var previews: some View {
        EnterNewPassword()
    }
}
