import SwiftUI

struct DividingLine: View {
    let when: String
    var body: some View {
        HStack {
            Rectangle()
                .foregroundColor(Color("text1"))
                .frame(height: 2)
                .cornerRadius(10)
            Text(when)
                .foregroundColor(Color("text1"))
                .font(.custom("Pretendard-ExtraBold", size: 14))
            Rectangle()
                .foregroundColor(Color("text1"))
                .frame(height: 2)
                .cornerRadius(10)
        }
    }
}

struct DividingLine_Previews: PreviewProvider {
    static var previews: some View {
        DividingLine(when: "3월 4일")
    }
}
