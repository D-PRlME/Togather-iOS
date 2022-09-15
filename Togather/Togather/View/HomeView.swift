
import SwiftUI
import SwiftUIFlowLayout

var DevLanguage: [String] = ["Swift", "Java", "Kotlin", "JS", "Python", "Flutter"]
var DevColor: [Color] = [.orange, .red, .purple, .yellow, .green, .blue]
var Developer: [String] = ["홍승재", "길근우", "정승훈", "강용수", "김은오", "유찬홍"]

struct HomeView: View {
    
    @State var GoPostDetail = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack() {
                ColorManager.BackgroundColor1.ignoresSafeArea()
                VStack(spacing: 0) {
                    ScrollView() {
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack {
                                ForEach(0..<DevLanguage.count, id: \.self) { i in
                                    VStack {
                                        Rectangle()
                                            .foregroundColor(DevColor[i])
                                            .frame(width: 56, height: 56)
                                            .cornerRadius(20)
                                            .padding(.horizontal, 4)
                                        Text(DevLanguage[i])
                                            .foregroundColor(.black)
                                            .font(.custom("Pretendard-ExtraBold", size: 14))
                                            .padding(.bottom, 9)
                                    }
                                }
                            }
                            .padding(.horizontal,  8)
                        }
                        Rectangle()
                            .foregroundColor(Color("TabBarStroke"))
                            .frame(width: proxy.size.width, height: 1)
                        ForEach(0..<6, id: \.self) { i in
                            Button {
                                GoPostDetail = true
                            } label: {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("제목제목제목제목제목제목제목제목제목제목제목")
                                        .foregroundColor(.black)
                                        .font(.custom("Pretendard-Bold", size: 24))
                                        .multilineTextAlignment(.leading)
                                    TagsFlowLayout()
                                    Rectangle()
                                        .foregroundColor(Color("TabBarStroke"))
                                        .frame(width: proxy.size.width - 70, height: 1)
                                    HStack(spacing: 8) {
                                        Image(systemName: "person.fill")
                                            .foregroundColor(.black)
                                            .frame(width: 33, height: 33)
                                            .overlay(Circle().stroke().foregroundColor(Color("TabBarStroke")))
                                        Text(Developer[i])
                                            .foregroundColor(.black)
                                            .font(.custom("Pretendard-Medium", size: 16))
                                        Spacer()
                                        Text("1시간 전")
                                            .foregroundColor(.black)
                                            .font(.custom("Pretendard-Medium", size: 16))
                                    }
                                }
                                .padding(12)
                                .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                                .cornerRadius(8)
                            }
                            .buttonStyle(.plain)

                        }
                        .sheet(isPresented: $GoPostDetail, content: {
                            PostDetail()
                        })
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        
                    }
//                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
                    
                }
                Spacer()
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
