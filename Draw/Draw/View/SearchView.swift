import SwiftUI
import SwiftUIFlowLayout

struct SearchBar: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            ZStack {
                HStack {
                    TextField("검색", text: $text)
                        .font(.custom("Pretendard-Medium", size: 20))
                        .foregroundColor(.primary)
                    Image("SearchOff")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .padding(.horizontal, 10)
                }
                .padding(.vertical, 12)
                .padding(.leading, 12)
                .background(Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                .cornerRadius(6)
                HStack {
                    TextField("검색", text: $text)
                        .font(.custom("Pretendard-Medium", size: 20))
                        .foregroundColor(Color("TabBarNoSelectedColor"))
                    Image("SearchOff")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .padding(.horizontal, 10)
                }
                .padding(.leading, 12)
                .padding(.vertical, 10)
                .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                .cornerRadius(6)
                .padding(.horizontal, 2)
            }
        }
    }
}

struct SearchView: View {
    
    @State var text = ""
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor1.ignoresSafeArea()
                VStack(spacing: 0) {
                    ScrollView(showsIndicators: true) {
                        SearchBar(text: $text)
                            .padding(.top, 11)
                            .padding(.bottom, 16)
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
                        HStack {
                            ZStack {
                                Text("모든 태그 보기")
                                    .font(.custom("Pretendard-Bold", size: 18))
                                    .padding(.horizontal, 13)
                                    .padding(.vertical, 7)
                                    .background(Color(red: 0.7, green: 0.6, blue: 0.004))
                                    .cornerRadius(37)
                                Text("모든 태그 보기")
                                    .font(.custom("Pretendard-Bold", size: 18))
                                    .padding(.horizontal, 11)
                                    .padding(.vertical, 5)
                                    .background(Color(red: 0.882, green: 0.678, blue: 0.004))
                                    .cornerRadius(37)
                            }
                            Spacer()
                        }
                        .padding(.leading, 3)
                        
                        Rectangle()
                            .foregroundColor(Color("TabBarStroke"))
                            .frame(width: proxy.size.width - 32, height: 1)
                            .padding(.top, 9)
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
                            .padding(.vertical, 4)
                        }
                    }
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
