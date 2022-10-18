import SwiftUI

struct LoginNavigationButton: View {
    var body: some View {
        HStack(alignment: .center) {
            NavigationLink {
                SignUpView()
            } label: {
                VStack(spacing: 0) {
                    Rectangle().frame(height: 0)
                    Text("회원가입")
                        .font(.mainText1m)
                        .foregroundColor(.whiteElevated4)
                }
            }.frame(height: 48)
            
            NavigationLink {
                SignUpView()
            } label: {
                VStack(spacing: 0) {
                    Rectangle().frame(height: 0)
                    Text("비밀번호 변경")
                        .font(.mainText1m)
                        .foregroundColor(.whiteElevated4)
                }
            }.frame(height: 48)
        }
    }
}

struct LoginNavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        LoginNavigationButton()
    }
}
