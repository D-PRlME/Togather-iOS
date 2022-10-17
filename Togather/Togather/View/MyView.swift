
import SwiftUI
import Kingfisher
import CarPlay
import SwiftUIFlowLayout

@available(iOS 16.0, *)
struct MyView: View {
    
    @State var GoEditInfoModal = false
    @State var GoMyPost = false
    @State var GoDevelopers = false
    @State var GoChangePassword = false
    @State var GoLogout = false
    
    @StateObject var logoutVM = LogoutViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor.ignoresSafeArea()
                VStack(alignment: .leading, spacing: 12) {
                    
                    VStack {
                        HStack(spacing: 0) {
                            KFImage.url(URL(string: Account.profileImagLink ?? ""))
                                .placeholder {
                                    Circle().fill(Color.secondary)
                                        .frame(width: 48, height: 48)
                                }
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 48, height: 48)
                                .overlay(Circle().stroke().foregroundColor(Color("TabBarStroke")))
                                .padding(.trailing, 8)
                            VStack(alignment: .leading) {
                                Text(Account.ID ?? "")
                                    .foregroundColor(.black)
                                    .font(.custom("Pretendard-Medium", size: 20))
                                
                                Text(Account.email ?? "")
                                    .foregroundColor(.secondary)
                                    .font(.custom("Pretendard-Medium", size: 16))
                            }
                            Spacer()
                        }
                        
                        FlowLayout(mode: .scrollable,
                                   items: Account.positions ?? [],
                                  itemSpacing: 2) { index in
                            
                            Text(index.PositionTypeChange)
                                .foregroundColor(.white)
                                .font(.custom("Pretendard-ExtraBold", size: 14))
                                .padding(4)
                                .background(Color.black)
                                .cornerRadius(4)
                        }
                    }
                    .padding(10)
                    
                    Divider()
                    
                    Button {
                        print("MyView -> 계정 정보 수정 -> EditInfo")
                        GoEditInfoModal = true
                    } label: {
                        HStack {
                            Text("계정 정보 수정")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Medium", size: 18))
                                .padding(.leading, 12)
                                .padding(.vertical, 14)
                            Spacer()
                        }
                        .frame(width: proxy.size.width - 40)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .cornerRadius(8)
                    } .sheet(isPresented: self.$GoEditInfoModal) {
                        EditInfo()
                    }
                    
                    Button {
                        GoChangePassword = true
                    } label: {
                        HStack {
                            Text("비밀번호 변경")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Medium", size: 18))
                                .padding(.leading, 12)
                                .padding(.vertical, 14)
                            Spacer()
                        }
                        .frame(width: proxy.size.width - 40)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .cornerRadius(8)
                    }
                    .fullScreenCover(isPresented: $GoChangePassword) {
                        ChangePasswordVerify()
                    }
                    
                    Button {
                        GoMyPost = true
                    } label: {
                        HStack {
                            Text("내 게시글 보기")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Medium", size: 18))
                                .padding(.leading, 12)
                                .padding(.vertical, 14)
                            Spacer()
                        }
                        .frame(width: proxy.size.width - 40)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .cornerRadius(8)
                    }
                    .sheet(isPresented: $GoMyPost) {
                        MyPost()
                    }

                    Button {
                        GoDevelopers = true
                    } label: {
                        HStack {
                            Text("개발자들")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Medium", size: 18))
                                .padding(.leading, 12)
                                .padding(.vertical, 14)
                            Spacer()
                        }
                        .frame(width: proxy.size.width - 40)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .cornerRadius(8)
                    }
                    .sheet(isPresented: $GoDevelopers) {
                        Developers()
                    }
                    
                    Button {
                        GoLogout = true
                    } label: {
                        HStack {
                            Text("로그아웃")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Medium", size: 18))
                                .padding(.leading, 12)
                                .padding(.vertical, 14)
                            Spacer()
                        }
                        .frame(width: proxy.size.width - 40)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .cornerRadius(8)
                        
                        .alert("로그아웃", isPresented: $GoLogout) {
                            Button("로그아웃", role: .destructive) {
                                logoutVM.logout()
                            }
                            Button("취소", role: .cancel) { }
                        } message: {
                            Text("로그아웃 하시겠습니까?")
                        }
                        
                    }
                    
                    .fullScreenCover(isPresented: $logoutVM.isSucced) {
                        NavigationView {
                            LoginView()
                        }
                    }
                    
                    Spacer()
                }
//                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
                .padding(.horizontal, 20)
            }
        }
    }
}

@available(iOS 16.0, *)
struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
