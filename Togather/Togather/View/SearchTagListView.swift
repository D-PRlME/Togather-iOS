import SwiftUI
import Kingfisher

struct SearchTagListView: View {
    @StateObject var tagVM = TagViewModel()
    //    @State var search: String = ""
    
    @Binding var goBack: Bool
    
    @Binding var tagBtnValue: String
    
    @StateObject var searchVM = SearchViewModel()
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                Image("CloseBtn")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 16)
                    .padding(.top, 16)
                    .onTapGesture {
                        self.goBack = false
                    }
            }
            
            HStack {
                Text("모든 태그 보기")
                    .font(.custom("Pretendard-Bold", size: 28))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                
                Spacer()
            }
            
            
            //            HStack {
            //                TextField("검색", text: $search)
            //                    .autocapitalization(.none)
            //                    .disableAutocorrection(true)
            //                    .font(.custom("Pretendard-Medium", size: 20))
            //                    .foregroundColor(.black)
            //                Image("SearchOff")
            //                    .resizable()
            //                    .frame(width: 28, height: 28)
            //            }
            //            .padding(12)
            //            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
            //            .cornerRadius(6)
            //            .padding(1)
            //            .background(Color("TabBarStroke"))
            //            .cornerRadius(6)
            //            .padding(.horizontal, 16)
            
            //list
            List(tagVM.tagValues, id: \.self) { data in
                Button {
//                    tagLists.removeAll()
//                    if tagLists.contains(data.name){
//                    } else {
//                        tagLists.append(data.name)
//                    }
                    if tagBtnValue == data.name {
                        tagBtnValue = ""
                        print("\(data.name) 태그 끄기")
                    } else {
                        tagBtnValue = data.name
                        print("\(data.name) 태그 켜기")
                    }
                } label: {
                    HStack {
                        KFImage(
                            URL(string: "\(data.image_url)")!
                        )
                        .placeholder {
                            Rectangle()
                                .frame(width: 45, height: 45)
                                .cornerRadius(15)
                                .foregroundColor(.secondary)
                                .opacity(0.1)
                        }
                        .resizable()
                        .frame(width: 45, height: 45)
                        .cornerRadius(15)
                        .overlay(
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(width: 45, height: 45)
                                .opacity(0.5)
                                .cornerRadius(15)
                                .overlay(
                                    Image("WhiteCheck")
                                        .resizable()
                                        .frame(width: 28, height: 28)
                                )
                                .opacity(tagBtnValue == data.name ? 1 : 0)
                        )
                        
                        Text("\(data.name)")
                            .font(.custom("Pretendard-Medium", size: 20))
                    }
                }
            }
        }
        .listStyle(.inset)
        .onAppear {
            tagVM.GstTagDatas()
        }
        .onDisappear() {
        }
    }
}

//struct TagListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TagListView()
//    }
//}
