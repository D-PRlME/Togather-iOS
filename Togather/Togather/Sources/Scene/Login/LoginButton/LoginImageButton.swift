import SwiftUI

struct LoginImageButton: View {
    var body: some View {
        HStack(spacing: 12) {
            Spacer()
            Image("GoogleLogo")
                .resizable()
                .frame(width: 48, height: 48)
            Image("AppleLogo")
                .resizable()
                .frame(width: 48, height: 48)
            Spacer()
        }
    }
}

struct LoginImageButton_Previews: PreviewProvider {
    static var previews: some View {
        LoginImageButton()
    }
}
