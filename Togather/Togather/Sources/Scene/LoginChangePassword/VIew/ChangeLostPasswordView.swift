import SwiftUI

struct ChangeLostPasswordView: View {
    @StateObject var changeLostPasswordViewModel = ChangeLostPasswordViewModel()
    let email: String
    var body: some View {
        GeometryReader { proxy in
            NavigationLink(destination: ChangePasswordEmailSuccessView(), tag: 1, selection: $changeLostPasswordViewModel.goSucced) { EmptyView() }
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
                        text: $changeLostPasswordViewModel.newPassword,
                        message: changeLostPasswordViewModel.errorMessage,
                        isError: $changeLostPasswordViewModel.isError
                    )
                    if !changeLostPasswordViewModel.isError {
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
                    isDisable: .constant(!changeLostPasswordViewModel.passwordValueCheck()),
                    title: "다음",
                    action: {
                        changeLostPasswordViewModel.changePassword()
                    }
                )
                .padding(.bottom, proxy.safeAreaInsets.bottom == 0 ? 30 : 5)
            } // Vstack
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .onAppear {
            changeLostPasswordViewModel.email = email
        }
        .navigationBarHidden(true)
    }
}

struct ChangeLostPassword_Previews: PreviewProvider {
    static var previews: some View {
        ChangeLostPasswordView(email: "email")
    }
}
