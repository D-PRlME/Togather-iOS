import SwiftUI
import Kingfisher

struct TagListView: View {
    @StateObject var tagVM = TagViewModel()
    @Binding var goBack: Bool
    @Binding var tagLists: [String]
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
            List {
                ForEach(tagVM.tagValues, id: \.self) { data in
                    Button {
                        DispatchQueue.main.async {
                            if tagLists.contains(data.name) {
                                self.tagLists.removeAll { $0 == data.name }
                            } else {
                                self.tagLists.append(data.name)
                            }
                        }
                    } label: {
                        HStack {
                            KFImage(
                                URL(string: "\(data.imageUrl)")!
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
                                    .opacity(tagLists.contains(data.name) ? 1 : 0)
                            )
                            Text("\(data.name)")
                                .font(.title3m)
                                .foregroundColor(.text)
                        }
                    }
                }
            }
            .listStyle(.inset)
        }
        .onAppear {
            tagVM.getTagDatas()
        }
    }
}

struct TagListView_Previews: PreviewProvider {
    static var previews: some View {
        TagListView(
            goBack: .constant(true),
            tagLists: .constant(["Swift", "Node.js"])
        )
    }
}
