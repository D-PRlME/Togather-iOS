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
                ColorManager.BackgroundColor.ignoresSafeArea()
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        SearchTextField(
                            placeholder: "검색",
                            text: $searchViewModel.title,
                            action: {
                                tagBtnValue.removeAll()
                                searchViewModel.postTitle()
                            }
                        )
                        .padding(.top, 11)
                        .padding(.bottom, 16)
                        
                        SearchTagLabel(tag: tagBtnValue)
                            .padding(.bottom, 8)
                        
                        PostButton(
                            title: "모든 태그 보기",
                            backgroundColor: .main,
                            cornerColor: .mainDarken,
                            action: {
                                goTagList = true
                            }
                        )
                        Divider()
                            .padding(.top, 8)
                    }
                    .padding(.horizontal, 16)
                    .sheet(
                        isPresented: $goTagList,
                        onDismiss: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                searchViewModel.title = ""
                                searchViewModel.tag = tagBtnValue
                                searchViewModel.postTag()
                            }
                        },
                        content: {
                            SearchTagListView(goBack: $goTagList, tagBtnValue: $tagBtnValue)
                        }
                    )
                    
                    ScrollView {
                        ForEach(searchViewModel.postList, id: \.post_id) { data in
                            Button {
                                GoPostDetail = true
                                print("homeview :",data.post_id)
                            } label: {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(data.title)
                                        .foregroundColor(.text)
                                        .font(.title2b)
                                        .multilineTextAlignment(.leading)
                                        .padding(.leading, 5)
                                    
                                    FlowLayout(mode: .scrollable,
                                               items: data.tags,
                                               itemSpacing: 3) {
                                        Text($0.name)
                                            .foregroundColor(.text)
                                            .font(.maintext2m)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color.whiteElevated2)
                                            .cornerRadius(37)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 37)
                                                    .stroke(style: .init(lineWidth: 1))
                                                    .foregroundColor(.whiteElevated3)
                                            )
                                    }
                                    
                                    Divider()
                                    
                                    HStack(spacing: 8) {
                                        KFImage.url(URL(string: data.users.profile_image_url))
                                            .placeholder {
                                                Circle().fill(Color.whiteElevated2)
                                            }
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 33, height: 33)
                                            .padding(.horizontal, 4)
                                            .overlay(Circle().stroke(lineWidth: 1).foregroundColor(.whiteElevated3))
                                        
                                        Text(data.users.user_name)
                                            .foregroundColor(.black)
                                            .font(.maintext2m)
                                        
                                        Spacer()
                                        
                                        Image("GrayHeart")
                                            .resizable()
                                            .frame(width: 16, height: 13)
                                        
                                        Text(String(data.like_count))
                                            .foregroundColor(.whiteElevated4)
                                            .font(.maintext2m)
                                        Image("SeperateBar")
                                            .resizable()
                                            .frame(width: 1, height: 15)
                                        Text(data.created_at)
                                            .foregroundColor(.whiteElevated4)
                                            .font(.maintext2m)
                                    }
                                }
                                .padding(12)
                                .background(Color.whiteElevated1)
                                .cornerRadius(8)
                                .padding(.vertical, 6)
                            }
                            .sheet(
                                isPresented: $GoPostDetail,
                                onDismiss: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        if !searchViewModel.title.isEmpty {
                                            searchViewModel.tag.removeAll()
                                            searchViewModel.postTitle()
                                        } else if tagBtnValue != "" {
                                            searchViewModel.postTag()
                                        }
                                    }
                                },
                                content: {
                                    PostDetail(
                                        showModal: self.$GoPostDetail,
                                        postID: data.post_id
                                    )
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 16)
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
