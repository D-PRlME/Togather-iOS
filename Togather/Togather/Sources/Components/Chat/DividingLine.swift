import SwiftUI

struct DividingLine: View {
    let when: String
    var body: some View {
        HStack {
            Rectangle()
                .foregroundColor(Color.whiteElevated4)
                .frame(height: 2)
                .cornerRadius(10)
            Text(when)
                .foregroundColor(Color.whiteElevated4)
                .font(.indicator)
            Rectangle()
                .foregroundColor(Color.whiteElevated4)
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
