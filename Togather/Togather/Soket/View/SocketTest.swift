import SwiftUI

struct SocketTest: View {
    @StateObject var socketViewModel = SocketViewModel()
    var body: some View {
        VStack {
            Button {
                socketViewModel.socketCounnect()
            } label: {
                Text("소켓 on")
                    .frame(width: 100, height: 100)
            }
            Button {
                socketViewModel.socketDisconnect()
            } label: {
                Text("소켓 off")
                    .frame(width: 100, height: 100)
            }
            Button {
                socketViewModel.onError()
            } label: {
                Text("소켓 error")
                    .frame(width: 100, height: 100)
            }
            Button {
                socketViewModel.onChat()
            } label: {
                Text("소켓 chat")
                    .frame(width: 100, height: 100)
            }
            Button {
                socketViewModel.onRoom()
            } label: {
                Text("소켓 room")
                    .frame(width: 100, height: 100)
            }
        }
    }
}

struct SocketTest_Previews: PreviewProvider {
    static var previews: some View {
        SocketTest()
    }
}
