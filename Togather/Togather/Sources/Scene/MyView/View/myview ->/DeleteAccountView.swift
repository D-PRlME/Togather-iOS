import SwiftUI
import Kingfisher

struct DeleteAccount: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showAlert = false
    @Binding var goSignView: Bool
    @StateObject var quitAccountViewModel = QuitAccountViewModel()
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                NavigationLink(destination: Text("View #2"), isActive: $quitAccountViewModel.isSucced) { EmptyView() }
                ColorManager.BackgroundColor.ignoresSafeArea()
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Spacer()
                        Image("CloseBtn")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.top, 16)
                            .onTapGesture {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                    }
                    Text("계정삭제")
                        .foregroundColor(.black)
                        .font(.title1b)
                        .padding(.top, 40)
                    Text("계정을 삭제하려면 비밀번호를 입력해 주세요.")
                        .foregroundColor(.black)
                        .font(.maintext1m)
                    Spacer()
                    Button {
                        showAlert = true
                    } label: {
                        Text("계정 삭제")
                            .font(.maintext1b)
                            .foregroundColor(quitAccountViewModel.checkPassword() ?
                                .white0 : .whiteElevated4)
                            .frame(width: proxy.size.width - 32)
                            .padding(.vertical, 13)
                            .background(quitAccountViewModel.checkPassword() ? Color.error : Color.whiteElevated1)
                            .cornerRadius(6)
                            .padding(2)
                            .background(quitAccountViewModel.checkPassword() ? Color.redDarken : Color.whiteElevated3)
                            .cornerRadius(6)
                            .alert("정말 계정을 삭제하시겠습니까?", isPresented: $showAlert) {
                                Button("탈퇴", role: .destructive) {
                                    quitAccountViewModel.deleteAccount()
                                }
                                Button("취소", role: .cancel) { }
                            } message: {
                                Text("모든 입력한 정보, 작성한 글이 서버에서 삭제되며 이 작업은 되돌릴 수 없습니다.")
                            }
                            .alert("안내", isPresented: $quitAccountViewModel.wrongPW) {
                                Button("확인", role: .cancel) { }
                            } message: {
                                Text("비밀번호가 올바르지 않습니다.")
                            }
                            .alert("안내", isPresented: $quitAccountViewModel.isSucced) {
                                Button("확인", role: .cancel) {
                                    self.presentationMode.wrappedValue.dismiss()
                                    goSignView = true
                                }
                            } message: {
                                Text("계정이 성공적으로 삭제되었습다.")
                            }
                    }
                }
                .padding(.horizontal, 16)
                VStack {
                    AuthTextField(
                        placeholder: "비밀번호",
                        isSecret: true,
                        text: $quitAccountViewModel.inputPassword,
                        message: ""
                    )
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 16)
            .navigationBarHidden(true)
        }
    }
}

// struct DeleteAccount_Previews: PreviewProvider {
//    static var previews: some View {
//        DeleteAccount(.constant(true))
//    }
// }
