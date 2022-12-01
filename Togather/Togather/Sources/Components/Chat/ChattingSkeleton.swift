import SwiftUI

struct ChattingSkeleton: View {
    var body: some View {
        VStack(spacing: 12) {
            Group {
                MychatSkeleton(line: 2)
                OpponentChatSkeleton()
                MychatSkeleton()
                MychatSkeleton()
                OpponentChatSkeleton(line: 2)
                OpponentChatSkeleton(line: 1)
                MychatSkeleton()
                OpponentChatSkeleton(line: 1)
                MychatSkeleton()
                MychatSkeleton()
            }
            Group {
                MychatSkeleton(line: 2)
            }
        }
    }
}

struct ChattingSkeleton_Previews: PreviewProvider {
    static var previews: some View {
        ChattingSkeleton()
    }
}
