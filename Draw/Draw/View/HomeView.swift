
import SwiftUI

struct HomeView: View {
    
    var DevLanguage: [String] = ["Swift", "Java", "Kotlin", "JS", "Pthon", "Flutter"]
    var DevColor: [Color] = [.orange, .red, .purple, .yellow, .green, .blue]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor1.ignoresSafeArea()
                VStack {
//                    Spacer()
//                        .frame(height: 100)
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            ForEach(0..<DevLanguage.count, id: \.self) { i in
                                VStack {
                                    Rectangle()
                                        .foregroundColor(DevColor[i])
                                        .frame(width: 56, height: 56)
                                        .cornerRadius(20)
                                        .padding(.horizontal, 8)
                                    Text(DevLanguage[i])
                                        .font(.custom("Pretendard-ExtraBold", size: 14))
                                        .padding(.bottom, 9)
                                }
                            }
                        }
                        .padding(.horizontal,  8)
                    }
                    Rectangle()
                        .foregroundColor(Color("TabBarStroke"))
                        .frame(width: proxy.size.width, height: 2)
                    
                    VStack(spacing: 0) {
                        ScrollView() {
                            ForEach(0..<6, id: \.self) { i in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("제목제목제목제목제목제목제목제목제목제목제목")
                                        .font(.custom("Pretendard-Bold", size: 24))
                                    HStack {
                                        ForEach(0..<3, id: \.self) {_ in
                                            ZStack {
                                                Text(DevLanguage[i])
                                                    .padding(.horizontal, 13)
                                                    .padding(.vertical, 7)
                                                    .font(.custom("Pretendard-Medium", size: 16))
                                                    .background(Color("TabBarStroke"))
                                                    .cornerRadius(37)
                                                Text(DevLanguage[i])
                                                    .font(.custom("Pretendard-Medium", size: 16))
                                                    .padding(.horizontal, 12)
                                                    .padding(.vertical, 6)
                                                    .background(Color(red: 0.905, green: 0.905, blue: 0.905))
                                                    .cornerRadius(37)
                                            }
                                        }
                                    }
                                    Rectangle()
                                        .foregroundColor(Color("TabBarStroke"))
                                        .frame(width: proxy.size.width - 70, height: 2)
                                    HStack(spacing: 8) {
                                        Image(systemName: "person.fill")
                                            .frame(width: 33, height: 33)
                                            .overlay(Circle().stroke().foregroundColor(Color("TabBarStroke")))
                                        Text("사람김")
                                            .font(.custom("Pretendard-Medium", size: 16))
                                        Spacer()
                                        Text("1시간 전")
                                            .font(.custom("Pretendard-Medium", size: 16))
                                    }
                                }
                                .padding(12)
                                .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                                .cornerRadius(8)
                            }
                            .padding(16)
                            
                        }
                        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
                        
                    }
                    Spacer()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
