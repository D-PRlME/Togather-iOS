import SwiftUI
import Kingfisher

struct DeleteAccount: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var SamePW = false
    @State var password = ""
    @State var showAlert = false
    
    @Binding var goSignView: Bool
    
    @StateObject var quitAccountVM = QuitAccountViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                NavigationLink(destination: Text("View #2"), isActive: $quitAccountVM.isSucced) { EmptyView() }
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
                        .font(.custom("Pretendard-Bold", size: 28))
                        .padding(.top, 40)
                    Text("계정을 삭제하려면 비밀번호를 입력해 주세요.")
                        .foregroundColor(.black)
                        .font(.custom("Pretendard-Medium", size: 18))
                    Spacer()
                    
                    Button(action: {
                        showAlert = true
                    }) {
                        Text("계정 삭제")
                            .font(.custom("Pretendard-Bold", size: 18))
                            .foregroundColor(quitAccountVM.checkPassword() ?
                                .black : Color(red: 0.47, green: 0.47, blue: 0.47))
                            .frame(width: proxy.size.width - 32)
                            .padding(.vertical, 13)
                            .background(quitAccountVM.checkPassword() ?
                                        Color(red: 0.996, green: 0.239, blue: 0.239) :
                                            Color(red: 0.97, green: 0.97, blue: 0.97))
                            .cornerRadius(6)
                            .padding(2)
                            .background(quitAccountVM.checkPassword() ? Color("RedStroke") : Color("TabBarStroke"))
                            .cornerRadius(6)
                        
                        
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
                }
                .padding(.horizontal, 16)
                VStack {
                    HStack(spacing: 8) {
                        KFImage.url(URL(string: Account.profileImagLink ?? ""))
                            .placeholder {
                                Circle().fill(Color.secondary)
                                    .frame(width: 48, height: 48)
                            }
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 48, height: 48)
                            .overlay(Circle().stroke().foregroundColor(Color("TabBarStroke")))
                        Text(Account.ID ?? "")
                            .foregroundColor(.black)
                            .font(.custom("Pretendard-Medium", size: 20))
                    }
                    SecureField("비밀번호", text: $quitAccountVM.inputPassword)
                        .font(.custom("Pretendard-Medium", size: 20))
                        .foregroundColor(.black)
                        .padding(.leading, 12)
                        .padding(.vertical, 10)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .cornerRadius(6)
                        .padding(1)
                        .background(Color("TabBarStroke"))
                        .cornerRadius(6)
                        .padding(.top, 8)
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 16)
            .navigationBarHidden(true)
        }
    }
}

//struct DeleteAccount_Previews: PreviewProvider {
//    static var previews: some View {
//        DeleteAccount(.constant(true))
//    }
//}
