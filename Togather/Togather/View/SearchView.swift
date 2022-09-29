import SwiftUI
import SwiftUIFlowLayout
import SwiftUIPullToRefresh
import Kingfisher

struct SearchView: View {
    @State var GoPostDetail = false
    @State var postList: [PostList] = []
    
    @State var tagBtnValue: String = ""
    @State var stringTagList: [String] = []
    @State var goTagList: Bool = false
    
    @StateObject var searchViewModel = SearchViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack() {
                ColorManager.BackgroundColor1.ignoresSafeArea()
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0){
                            HStack {
                                HStack {
                                    TextField("검색", text: $searchViewModel.title)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .font(.custom("Pretendard-Medium", size: 20))
                                        .foregroundColor(.black)
                                    Image("SearchOff")
                                        .resizable()
                                        .frame(width: 28, height: 28)
                                        .padding(.horizontal, 10)
                                        .onTapGesture {
                                            tagBtnValue.removeAll()
                                            searchViewModel.postTitle()
                                        }
                                }
                                .padding(12)
                                .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                                .cornerRadius(6)
                                .padding(1)
                                .background(Color("TabBarStroke"))
                                .cornerRadius(6)
                            }
                            .padding(.top, 11)
                            .padding(.bottom, 16)
                            if tagBtnValue != "" {
                                Text(tagBtnValue)
                                    .foregroundColor(.black)
                                    .font(.custom("Pretendard-Medium", size: 16))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                                    .cornerRadius(37)
                                    .padding(1)
                                    .background(Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                                    .cornerRadius(37)
                                    .padding(.trailing, 8)
                                    .padding(.bottom, 8)
                            }
                            
                            Button {
                                goTagList = true
                            } label: {
                                Text("모든 태그 보기")
                                    .foregroundColor(.black)
                                    .font(.custom("Pretendard-Bold", size: 18))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color(red: 0.882, green: 0.678, blue: 0.004))
                                    .cornerRadius(37)
                                    .padding(2)
                                    .background(Color("YellowStroke"))
                                    .cornerRadius(37)
                            }
                        }
                        .padding(.leading, 3)
                        .sheet(isPresented: $goTagList) {
                            SearchTagListView(goBack: $goTagList, tagBtnValue: $tagBtnValue)
                        }
                        
                        Rectangle()
                            .foregroundColor(Color("TabBarStroke"))
                            .frame(width: proxy.size.width - 32, height: 1)
                            .padding(.top, 9)
                        
                        ForEach(searchViewModel.postList, id: \.post_id) { data in
                            Button {
                                GoPostDetail = true
                                print("homeview :",data.post_id)
                                UserDefaults.standard.set(data.post_id, forKey: "postID")
                            } label: {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(data.title)
                                        .foregroundColor(.black)
                                        .font(.custom("Pretendard-Bold", size: 24))
                                        .multilineTextAlignment(.leading)
                                        .padding(.leading, 5)
                                    FlowLayout(mode: .scrollable,
                                               items: data.tags,
                                               itemSpacing: 0) {
                                        Text($0.name)
                                            .foregroundColor(.black)
                                            .font(.custom("Pretendard-Medium", size: 16))
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color(red: 0.905, green: 0.905, blue: 0.905))
                                            .cornerRadius(37)
                                            .padding(1)
                                            .background(Color("TabBarStroke"))
                                            .cornerRadius(37)
                                            .padding(.trailing, 8)
                                            .padding(.bottom, 8)
                                    }
                                    Rectangle()
                                        .foregroundColor(Color("TabBarStroke"))
                                        .frame(width: proxy.size.width - 56, height: 1)
                                    HStack(spacing: 8) {
                                        KFImage.url(URL(string: data.users.profile_image_url))
                                            .placeholder {
                                                Circle().fill(Color.secondary)
                                            }
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(width: 33, height: 33)
                                            .cornerRadius(20)
                                            .padding(.horizontal, 4)
                                            .overlay(Circle().stroke().foregroundColor(Color("TabBarStroke")))
                                        
                                        Text(data.users.user_name)
                                            .foregroundColor(.black)
                                            .font(.custom("Pretendard-Medium", size: 16))
                                        Spacer()
                                        Text(data.created_at)
                                            .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47, opacity: 1))
                                            .font(.custom("Pretendard-Medium", size: 16))
                                    }
                                }
                                .padding(12)
                                .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                                .cornerRadius(8)
                                .padding(.vertical, 6)
                            }
                            .sheet(isPresented: $GoPostDetail, content: {
                                PostDetail(
                                    showModal: self.$GoPostDetail
                                )
                            })
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
                .onChange(of: self.tagBtnValue) { (newValue) in
                    if newValue.isEmpty == false {
                        searchViewModel.tag = newValue
                        searchViewModel.postTag()
                    }
                }
            }
            Spacer()
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
