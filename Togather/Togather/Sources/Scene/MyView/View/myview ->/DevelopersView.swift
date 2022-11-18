import SwiftUI
import Alamofire
import Kingfisher

struct Developers: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private let developers: [String] = [
        "김성원",
        "조병진",
        "김상구",
        "김은빈",
        "홍승재",
        "정승훈",
        "심미진",
        "장지성"
    ]
    private let stack: [String] = [
        "백엔드",
        "iOS",
        "디자인",
        "백엔드",
        "iOS",
        "Android",
        "웹 프론트엔드",
        "웹 프론트엔드"
    ]
    private let githubID: [String] = [
        "lilseongwon",
        "BJCHO0501",
        "MONOTYPEEE",
        "rlaisqls",
        "HongSJae",
        "Tmdhoon2",
        "azure-553",
        "jisoung"
    ]
    private let imageUrlArr: [String] = [
        "https://avatars.githubusercontent.com/u/102791105?v=4",
        "https://avatars.githubusercontent.com/u/80248855?v=4",
        "https://avatars.githubusercontent.com/u/76112135?v=4",
        "https://avatars.githubusercontent.com/u/81006587?v=4",
        "https://avatars.githubusercontent.com/u/102791216?v=4",
        "https://avatars.githubusercontent.com/u/102812085?v=4",
        "https://avatars.githubusercontent.com/u/80371353?v=4",
        "https://avatars.githubusercontent.com/u/101026873?v=4"
    ]
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    var body: some View {
        ZStack {
            ColorManager.BackgroundColor.ignoresSafeArea()
            VStack {
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
                ScrollView(.vertical, showsIndicators: false) {
                    HStack {
                        Text("개발자들")
                            .foregroundColor(.black)
                            .font(.custom("Pretendard-Bold", size: 28))
                            .padding(.top, 40)
                        Spacer()
                    }
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(0..<developers.count, id: \.self) { index in
                            ZStack {
                                VStack(spacing: 8) {
                                    HStack(spacing: 0) {
                                        KFImage.url(URL(string: imageUrlArr[index]))
                                            .placeholder {
                                                Circle().fill(Color.secondary)
                                                    .frame(width: 56, height: 56)
                                                    .opacity(0.1)
                                            }
                                            .resizable()
                                            .clipShape(Circle())
                                            .frame(width: 62, height: 62)
                                        Spacer()
                                        Text(developers[index])
                                            .foregroundColor(.black)
                                            .font(.custom("Pretendard-Bold", size: 24))
                                            .padding(.trailing, 8)
                                    }
                                    HStack {
                                        Text(stack[index])
                                            .foregroundColor(.black)
                                            .font(.custom("Pretendard-Medium", size: 16))
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color(red: 0.905, green: 0.905, blue: 0.905))
                                            .cornerRadius(37)
                                            .padding(1)
                                            .background(Color("TabBarStroke"))
                                            .cornerRadius(37)
                                        Spacer()
                                    }
                                    Link(destination: URL(string: "https://github.com/" + githubID[index])!) {
                                        HStack(spacing: 0) {
                                            Image("LinkImage")
                                                .resizable()
                                                .frame(width: 12, height: 12)
                                                .padding(4)
                                            Text("Github")
                                                .foregroundColor(.black)
                                                .font(.custom("Pretendard-Medium", size: 18))
                                                .underline()
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            .padding(12)
                            .background(Color("TabBarFill"))
                            .cornerRadius(8)
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }
}

struct Developers_Previews: PreviewProvider {
    static var previews: some View {
        Developers()
    }
}
