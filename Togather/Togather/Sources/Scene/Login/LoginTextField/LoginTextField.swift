import SwiftUI

struct LoginTextField: View {
    @Binding var id: String
    @Binding var password: String
    
    var body: some View {
        VStack(spacing: 12) {
            AuthTextFiled(
                placeholder: "아이디",
                text: $id
            )
            
            AuthTextFiled(
                placeholder: "비밀번호",
                isSecret: true,
                text: $password
            )
        }
        
    }
}

struct LoginTextField_Previews: PreviewProvider {
    static var previews: some View {
        LoginTextField(
            id: .constant(""),
            password: .constant("")
        )
    }
}
