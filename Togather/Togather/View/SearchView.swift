import SwiftUI
import SwiftUIFlowLayout

struct SearchBar: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            HStack {
                TextField("검색", text: $text)
                    .font(.custom("Pretendard-Medium", size: 20))
                    .foregroundColor(.black)
                Image("SearchOff")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(.horizontal, 10)
            }
            .padding(12)
            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
            .cornerRadius(6)
            .padding(1)
            .background(Color("TabBarStroke"))
            .cornerRadius(6)
        }
    }
}

struct SearchView: View {
    
    @State var text = ""
    
    @State var GoPostDetail = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor1.ignoresSafeArea()
                VStack(spacing: 0) {
                    ScrollView(showsIndicators: true) {
                        SearchBar(text: $text)
                            .padding(.top, 11)
                            .padding(.bottom, 16)
                        TagsFlowLayout()
                        HStack {
                            Text("모든 태그 보기")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Bold", size: 18))
                                .padding(.horizontal, 11)
                                .padding(.vertical, 5)
                                .background(Color(red: 0.882, green: 0.678, blue: 0.004))
                                .cornerRadius(37)
                                .padding(2)
                                .background(Color("YellowStroke"))
                                .cornerRadius(37)
                            Spacer()
                        }
                        .padding(.leading, 3)
                        
                        Rectangle()
                            .foregroundColor(Color("TabBarStroke"))
                            .frame(width: proxy.size.width - 32, height: 1)
                            .padding(.top, 9)
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
                                        Text(Developer[0])
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
                            
                        }
                        .sheet(isPresented: $GoPostDetail, content: {
                            PostDetail()
                        })
                        .padding(.vertical, 8)
                    }
                    //                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
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
