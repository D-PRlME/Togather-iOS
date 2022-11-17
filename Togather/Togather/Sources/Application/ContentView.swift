import SwiftUI
import SwiftKeychainWrapper

struct ColorManager {
    static let BackgroundColor: Color = .white
}

struct ContentView: View {
    @ObservedObject var contentViewModel = ContentViewModel()
    @State private var changeTag: Int?
    private func autoLogin() {
        if KeychainWrapper.standard.bool(forKey: "auto") == true {
            contentViewModel.email = KeychainWrapper.standard.string(forKey: "id")!
            contentViewModel.password = KeychainWrapper.standard.string(forKey: "pw")!
            contentViewModel.login()
            changeTag = 1
        } else {
            changeTag = 2
        }
    }
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: TabBarView().navigationBarHidden(true), tag: 1, selection: $changeTag) { EmptyView() }
                NavigationLink(destination: LoginView().navigationBarHidden(true), tag: 2, selection: $changeTag) { EmptyView() }
            }
            .onAppear {
                autoLogin()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
