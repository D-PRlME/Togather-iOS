import SwiftUI
import Kingfisher

struct DeleteAccount: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var SamePW = false
    @State private var password = ""
    @State private var showAlert = false
    
    @Binding var goSignView: Bool
    
    @StateObject var quitAccountVM = QuitAccountViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
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
                        .foregroundColor(.text)
                        .font(.title1b)
                        .padding(.top, 40)
                    Text("계정을 삭제하려면 비밀번호를 입력해 주세요.")
                        .foregroundColor(.black)
                        .font(.maintext1m)
                    Spacer()
                    
                    DeleteAcountButton(
                        isDisable: .constant(false),
                        title: "계정 삭제",
                        action: {
                            showAlert = true
                        }
                    )
                    .alert("정말 계정을 삭제하시겠습니까?", isPresented: $showAlert) {
                        Button("진행", role: .destructive) {
                            quitAccountVM.deleteAccount()
                        }
                        Button("취소", role: .cancel) { }
                    } message: {
                        Text("모든 입력한 정보, 작성한 글이 서버에서 삭제되며 이 작업은 되돌릴 수 없습니다.")
                    }
                
                    .alert("안내" , isPresented: $quitAccountVM.wrongPW) {
                        Button("확인", role: .cancel) { }
                    } message: {
                        Text("비밀번호가 올바르지 않습니다.")
                    }
                
                    .alert("안내" , isPresented: $quitAccountVM.isSucced) {
                        Button("확인", role: .cancel) {
                            self.presentationMode.wrappedValue.dismiss()
                            goSignView = true
                        }
                    } message: {
                        Text("계정이 성공적으로 삭제되었습다.")
                    }
                }
                .padding(.horizontal, 16)
                
                
                VStack {
                    HStack(spacing: 8) {
                        KFImage.url(URL(string: Account.profileImageLink ?? ""))
                            .placeholder {
                                Circle().fill(Color.whiteElevated3)
                                    .frame(width: 48, height: 48)
                            }
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 48, height: 48)
                            .overlay(Circle().stroke().foregroundColor(.whiteElevated3))
                        Text(Account.ID ?? "")
                            .foregroundColor(.text)
                            .font(.title3m)
                    }
                    AuthTextField(
                        placeholder: "비밀번호",
                        isSecret: true,
                        text: $quitAccountVM.inputPassword
                    )
                    .padding(.top, 24)
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 16)
            .navigationBarHidden(true)
        }
    }
}

struct DeleteAccount_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccount(goSignView: .constant(true))
    }
}
