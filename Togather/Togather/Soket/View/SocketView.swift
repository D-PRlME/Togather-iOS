import SwiftUI

struct SocketView: View {
    @StateObject var SocketVM = SocketViewModel()
    var body: some View {
        VStack {
            Button {
                SocketVM.socketCounnect()
            } label: {
                Text("소켓 통신 시작")
            }
            
            Button {
                SocketVM.socketDisconnect()
            } label: {
                Text("소켓 통신 끝")
            }
            
            Button {
                
            } label: {
                Text("소켓 room")
            }
        }
    }
}

struct SocketView_Previews: PreviewProvider {
    static var previews: some View {
        SocketView()
    }
}
