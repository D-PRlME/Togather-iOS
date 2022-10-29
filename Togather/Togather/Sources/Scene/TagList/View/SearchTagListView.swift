import SwiftUI
import Kingfisher

struct SearchTagListView: View {
    @StateObject var tagVM = TagViewModel()
    
    @Binding var goBack: Bool
    @Binding var tagBtnValue: String
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                Image("CloseBtn")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding([.trailing, .top], 16)
                    .onTapGesture {
                        self.goBack = false
                    }
            }
            
            HStack {
                Text("모든 태그 보기")
                    .font(.title1b)
                    .foregroundColor(.text)
                    .padding(.horizontal, 16)
                
                Spacer()
            }
            
            //list
            List(tagVM.tagValues, id: \.self) { data in
                Button {
                    if tagBtnValue == data.name {
                        tagBtnValue = ""
                    } else {
                        tagBtnValue = data.name
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
                                .foregroundColor(.whiteElevated3)
                        }
                        .resizable()
                        .frame(width: 45, height: 45)
                        .cornerRadius(15)
                        .overlay(
                            Rectangle()
                                .foregroundColor(.text)
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
                            .font(.title3m)
                            .foregroundColor(.text)
                    }
                }
            }
        }
        .listStyle(.inset)
        .onAppear {
            tagVM.GstTagDatas()
        }
    }
}

struct SearchTagListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTagListView(
            goBack: .constant(true),
            tagBtnValue: .constant("Node.js")
        )
    }
}
