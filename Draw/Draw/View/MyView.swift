
import SwiftUI

struct MyView: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor3.ignoresSafeArea()
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 0) {
                        Image(systemName: "person.fill")
                            .frame(width: 48, height: 48)
                            .overlay(Circle().stroke().foregroundColor(Color("TabBarStroke")))
                            .padding(.leading, 10)
                            .padding(.trailing, 8)
                        Text(Developer[0])
                            .font(.custom("Pretendard-Medium", size: 20))
                        Spacer()
                    }
                    .padding(.top, 28)
                    .padding(.bottom, 12)
                    HStack {
                        Text("계정 정보 수정")
                            .font(.custom("Pretendard-Medium", size: 18))
                            .padding(.leading, 12)
                            .padding(.vertical, 14)
                        Spacer()
                    }
                    .frame(width: proxy.size.width - 40)
                    .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                    .cornerRadius(8)
                    HStack {
                        Text("비밀번호 변경")
                            .font(.custom("Pretendard-Medium", size: 18))
                            .padding(.leading, 12)
                            .padding(.vertical, 14)
                        Spacer()
                    }
                    .frame(width: proxy.size.width - 40)
                    .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                    .cornerRadius(8)
                    HStack {
                        Text("내 게시글 보기")
                            .font(.custom("Pretendard-Medium", size: 18))
                            .padding(.leading, 12)
                            .padding(.vertical, 14)
                        Spacer()
                    }
                    .frame(width: proxy.size.width - 40)
                    .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                    .cornerRadius(8)
                    HStack {
                        Text("개발자들")
                            .font(.custom("Pretendard-Medium", size: 18))
                            .padding(.leading, 12)
                            .padding(.vertical, 14)
                        Spacer()
                    }
                    .frame(width: proxy.size.width - 40)
                    .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                    .cornerRadius(8)
                    HStack {
                        Text("로그아웃")
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
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
                .padding(.horizontal, 20)
            }
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
