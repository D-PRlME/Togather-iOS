import SwiftUI
import SwiftUIFlowLayout
import SwiftUIPullToRefresh
import Kingfisher

struct SearchView: View {
    @State private var postList: [PostList] = []
    
    @State private var tagBtnValue: String = ""
    @State private var stringTagList: [String] = []
    @State private var goTagList: Bool = false
    
    @State private var isClose: Bool = false
    
    @StateObject var searchViewModel = SearchViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
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
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(searchViewModel.postList, id: \.postID) { data in
                            PostForm(
                                close: $isClose,
                                postData: data
                            )
                        }
                        .onChange(of: isClose) { newValue in
                            if newValue {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    if !searchViewModel.title.isEmpty {
                                        searchViewModel.tag.removeAll()
                                        searchViewModel.postTitle()
                                    } else if tagBtnValue != "" {
                                        searchViewModel.tag = tagBtnValue
                                        searchViewModel.postTag()
                                    }
                                    self.isClose = false
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, proxy.safeAreaInsets.bottom == 0 ? 106 : 86)
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
