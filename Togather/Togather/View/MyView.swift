
import SwiftUI
import Kingfisher

struct MyView: View {
    
    @State var GoEditInfoModal = false
    @State var GoMyPost = false
    @State var GoDevelopers = false
    @State var GoChangePassword = false
    
    @StateObject var getMyprofileVM = GetMyProfileViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor3.ignoresSafeArea()
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 0) {
                        KFImage.url(URL(string: getMyprofileVM.myProfilImageLink))
                            .placeholder {
                                Circle().fill(Color.secondary)
                                    .frame(width: 48, height: 48)
                            }
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 48, height: 48)
                            .overlay(Circle().stroke().foregroundColor(Color("TabBarStroke")))
                            .padding(.leading, 10)
                            .padding(.trailing, 8)
                        VStack(alignment: .leading) {
                            Text(getMyprofileVM.myID)
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Medium", size: 20))
                            
                            Text(getMyprofileVM.myEmail)
                                .foregroundColor(.secondary)
                                .font(.custom("Pretendard-Light", size: 15))
                        }
                        Spacer()
                    }
                    .padding(.top, 28)
                    .padding(.bottom, 12)
                    
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
                    Spacer()
                }
//                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
                .padding(.horizontal, 20)
            }
        }
        .onAppear {
            getMyprofileVM.GetMyprofile()
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
