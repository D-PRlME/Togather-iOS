import SwiftUI

struct MychatSkeleton: View {
    var line: Int = 1
    var body: some View {
        HStack(alignment: .bottom, spacing: 4) {
            Spacer()
            Rectangle()
                .frame(width: 35, height: 12)
                .foregroundColor(.whiteElevated3)
                .cornerRadius(10)
            Rectangle()
                .frame(width: 140, height: 32 * CGFloat(line))
                .foregroundColor(.whiteElevated3)
                .cornerRadius(20)
        }
    }
}

struct MychatSkeleton_Previews: PreviewProvider {
    static var previews: some View {
        MychatSkeleton()
    }
}
