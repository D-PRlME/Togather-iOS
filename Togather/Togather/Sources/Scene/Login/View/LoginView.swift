import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            ColorManager.BackgroundColor.ignoresSafeArea()
            NavigationLink(destination: TabBarView(), tag: 1, selection: $loginViewModel.viewTag ) { EmptyView() }
            VStack(alignment: .leading, spacing: 12) {
                Spacer()
                LoginTitle()
                
                LoginTextField(
                    id: $loginViewModel.email,
                    password: $loginViewModel.password
                )
                
                AuthButton(
                    isLoading: $loginViewModel.showProgrees,
                    text: "로그인",
                    action: {
                        loginViewModel.showProgrees = true
                        loginViewModel.login()
                    }
                )
                
                LoginNavigationButton()
                Spacer()
                LoginImageButton()
            }
        }
        .padding([.horizontal, .bottom], 16)
        .alert("안내", isPresented: $loginViewModel.showError) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(loginViewModel.errorMessage)
        }
        .navigationBarHidden(true)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
