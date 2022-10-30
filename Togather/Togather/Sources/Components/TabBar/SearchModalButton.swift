import SwiftUI

struct SearchModalButton: View {
    @Binding var tabIndex: TabIndex
    @Binding var showModal: Bool
    let proxy: GeometryProxy
    var body: some View {
        Button {
            self.showModal.toggle()
        } label: {
            VStack {
                Image(tabIndex == .write ? "WritingOn" : "WritingOff")
                    .font(.system(size: 25))
                    .foregroundColor(tabIndex == .write ? .main : .whiteElevated4)
                    .frame(width: 28, height: 28)
                Text("글쓰기")
                    .font(.custom("Pretendard-Bold", size: 14))
                    .foregroundColor(tabIndex == .write ? .main : .whiteElevated4)
                Spacer()
            }
            .frame(width: proxy.size.width/6, height: 50)
        }
        .buttonStyle(.plain)
        .sheet(isPresented: self.$showModal) {
            WritingView(showModal: self.$showModal)
        }
        .buttonStyle(.plain)
    }
}

//struct SearchModalButton_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchModalButton()
//    }
//}
