//
//  SocketTest.swift
//  Togather
//
//  Created by 조병진 on 2022/09/28.
//

import SwiftUI

struct SocketTest: View {
    @StateObject var socketVM = SocketViewModel()
    
    var body: some View {
        VStack {
            
            Button {
                socketVM.socketCounnect()
            } label: {
                Text("소켓 on")
                    .frame(width: 100, height: 100)
            }
            
            
            Button {
                socketVM.socketDisconnect()
            } label: {
                Text("소켓 off")
                    .frame(width: 100, height: 100)
            }
            
            Button {
                socketVM.onError()
            } label: {
                Text("소켓 error")
                    .frame(width: 100, height: 100)
            }
            
            Button {
                socketVM.onChat()
            } label: {
                Text("소켓 chat")
                    .frame(width: 100, height: 100)
            }
            
            Button {
                socketVM.onRoom()
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
