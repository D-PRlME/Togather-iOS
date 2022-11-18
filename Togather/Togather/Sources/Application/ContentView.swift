import SwiftUI
import SwiftKeychainWrapper

struct ColorManager {
    static let BackgroundColor: Color = .white
}

struct ContentView: View {
    @ObservedObject var contentViewModel = ContentViewModel()
    private func autoLogin() {
        if KeychainWrapper.standard.bool(forKey: "auto") == true {
            contentViewModel.email = KeychainWrapper.standard.string(forKey: "id")!
            contentViewModel.password = KeychainWrapper.standard.string(forKey: "pw")!
            contentViewModel.autoLogin()
        } else {
            contentViewModel.justLogin()
        }
    }
    var body: some View {
        ZStack {
            Image("LOGO")
                .resizable()
                .frame(width: 148, height: 148)
            VStack {
                Spacer()
                Text("ToGather")
                    .foregroundColor(Color(white: 0, opacity: 0.5))
                    .font(.title2b)
                    .padding(.bottom, 40)
            }
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $contentViewModel.fullScreenToTabBarView, content: {
            NavigationView {
                TabBarView()
            }
        })
        .fullScreenCover(isPresented: $contentViewModel.fullScreenToLoginView, content: {
            NavigationView {
                LoginView()
            }
        })
        .onAppear {
            autoLogin()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
