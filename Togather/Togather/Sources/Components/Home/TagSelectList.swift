import SwiftUI
import Kingfisher

struct TagSelectList: View {
    @Binding var tags: [Tags]
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                    ForEach(tags, id: \.self) { index in
                        VStack {
                            KFImage.url(URL(string: index.image_url))
                                .placeholder {
                                    Circle().fill(Color.whiteElevated3)
                                        .frame(width: 56, height: 56)
                                }
                                .resizable()
                                .frame(width: 56, height: 56)
                                .cornerRadius(20)
                                .padding(.horizontal, 4)
                            
                            Text(index.name)
                                .foregroundColor(.black)
                                .font(.maintext2b)
                                .padding(.bottom, 9)
                        }
                        .onTapGesture {
                            print(index.name)
                        }
                    }
                }
                .padding(.horizontal, 8)
            }
            Rectangle()
                .foregroundColor(.whiteElevated3)
                .frame(height: 1)
        }
    }
}

struct TagSelectList_Previews: PreviewProvider {
    static var previews: some View {
        TagSelectList(
            tags: .constant([Tags(name: "SpringBoot", image_url: "https://wouldyou1214.s3.amazonaws.com/SPRING.png"), Tags(name: "MySQL", image_url: "https://wouldyou1214.s3.amazonaws.com/MySQL.png"), Tags(name: "Node.js", image_url: "https://wouldyou1214.s3.amazonaws.com/Node.js.pn")])
        )
    }
}
