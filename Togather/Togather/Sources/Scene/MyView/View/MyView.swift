import SwiftUI
import Kingfisher
import CarPlay
import SwiftUIFlowLayout

struct MyView: View {
    @State private var goEditInfoModal = false
    @State private var goMyPost = false
    @State private var goDevelopers = false
    @State private var goChangePassword = false
    @State private var goLogout = false
    @State private var profileImageLink = Account.profileImageLink ?? ""
    @StateObject var logoutVM = LogoutViewModel()
    var body: some View {
        ZStack {
            NavigationLink(destination: ChangePasswordVerify(), isActive: $goChangePassword) {
                EmptyView()
            }// 비밀번호 변경은 navigationLink로 넘겨야함
            ColorManager.BackgroundColor.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                    .frame(height: 28)
                VStack {
                    HStack(spacing: 0) {
                        KFImage.url(URL(string: profileImageLink))
                            .placeholder {
                                Circle().fill(Color.whiteElevated3)
                                    .frame(width: 48, height: 48)
                            }
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 48, height: 48)
                            .overlay(Circle().stroke().foregroundColor(.whiteElevated3))
                            .padding(.trailing, 8)
                        VStack(alignment: .leading) {
                            Text(Account.identifier ?? "")
                                .foregroundColor(.text)
                                .font(.title3b)
                            Text(Account.email ?? "")
                                .foregroundColor(.whiteElevated4)
                                .font(.maintext2m)
                        }
                        Spacer()
                    }
                    FlowLayout(mode: .scrollable,
                               items: Account.positions ?? [],
                               itemSpacing: 2) { index in
                        Text(index.positionTypeChange)
                            .foregroundColor(.white0)
                            .font(.indicator)
                            .padding(4)
                            .background(Color.black)
                            .cornerRadius(4)
                    }
                }
                .padding(10)
                Divider()
                    .padding(.bottom, 12)
                VStack(spacing: 12) {
                    MyViewButton(
                        text: "계정 정보 수정",
                        action: {
                            goEditInfoModal = true
                        }
                    )
                    .sheet(isPresented: self.$goEditInfoModal) {
                        EditInfo()
                    }
                    MyViewButton(
                        text: "비밀번호 변경",
                        action: {
                            goChangePassword = true
                        }
                    )
                    MyViewButton(
                        text: "내 게시글 보기",
                        action: {
                            goMyPost = true
                        }
                    )
                    .sheet(isPresented: $goMyPost) {
                        MyPost()
                    }
                    MyViewButton(
                        text: "개발자들",
                        action: {
                            goDevelopers = true
                        }
                    )
                    .sheet(isPresented: $goDevelopers) {
                        Developers()
                    }
                    MyViewButton(
                        text: "로그아웃",
                        action: {
                            goLogout = true
                        }
                    )
                    .alert("로그아웃", isPresented: $goLogout) {
                        Button("로그아웃", role: .destructive) {
                            logoutVM.logout()
                        }
                        Button("취소", role: .cancel) { }
                    } message: {
                        Text("로그아웃 하시겠습니까?")
                    }
                    .fullScreenCover(isPresented: $logoutVM.isSucced) {
                        NavigationView {
                            LoginView()
                        }
                    }
                    Spacer()
                }
            }
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
            .padding(.horizontal, 20)
            .onChange(of: goEditInfoModal) { newValue in
                if !newValue {
                    profileImageLink = Account.profileImageLink ?? ""
                }
            }
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
