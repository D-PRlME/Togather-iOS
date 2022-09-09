
import SwiftUI
import SwiftUIFlowLayout

var DevLanguage: [String] = ["Swift", "Java", "Kotlin", "JS", "Python", "Flutter"]
var DevColor: [Color] = [.orange, .red, .purple, .yellow, .green, .blue]
var Developer: [String] = ["홍승재", "길근우", "정승훈", "강용수", "김은오", "유찬홍"]

struct HomeView: View {
    
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
                            VStack(alignment: .leading, spacing: 8) {
                                Text("제목제목제목제목제목제목제목제목제목제목제목")
                                    .font(.custom("Pretendard-Bold", size: 24))
                                FlowLayout(mode: .scrollable,
                                           items: DevLanguage,
                                           itemSpacing: 5) {index in
                                    ZStack {
                                        Text(index)
                                            .font(.custom("Pretendard-Medium", size: 16))
                                            .padding(.horizontal, 13)
                                            .padding(.vertical, 7)
                                            .background(Color("TabBarStroke"))
                                            .cornerRadius(37)
                                        Text(index)
                                            .font(.custom("Pretendard-Medium", size: 16))
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color(red: 0.905, green: 0.905, blue: 0.905))
                                            .cornerRadius(37)
                                    }
                                }
                                Rectangle()
                                    .foregroundColor(Color("TabBarStroke"))
                                    .frame(width: proxy.size.width - 70, height: 1)
                                HStack(spacing: 8) {
                                    Image(systemName: "person.fill")
                                        .frame(width: 33, height: 33)
                                        .overlay(Circle().stroke().foregroundColor(Color("TabBarStroke")))
                                    Text(Developer[i])
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
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        
                    }
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
//
//struct FlowLayout_Previews: PreviewProvider {
//  static var previews: some View {
//    FlowLayout(mode: .scrollable,
//               items: ["Some long item here", "And then some longer one",
//                       "Short", "Items", "Here", "And", "A", "Few", "More",
//                       "And then a very very very long one"],
//               itemSpacing: 4) {
//      Text($0)
//        .font(.system(size: 12))
//        .foregroundColor(.black)
//        .padding()
//        .background(RoundedRectangle(cornerRadius: 4)
//                               .border(Color.gray)
//                               .foregroundColor(Color.gray))
//    }.padding()
//  }
//}
