import SwiftUI

struct AuthTextFiled: View {
    let placeholder: String
    let isSecret: Bool
    @State private var isShow = true
    @Binding var text: String
    
    init (
        placeholder: String,
        isSecret: Bool,
        text: Binding<String>
    ) {
        self.placeholder = placeholder
        self.isSecret = isSecret
        self._text = text
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                HStack {
                    if isShow {
                        TextField(
                            placeholder,
                            text: $text
                        )
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .font(.title3m)
                        .padding(.leading, 10)
                    } else {
                        SecureField(
                            placeholder,
                            text: $text
                        )
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .font(.title3m)
                        .padding(.leading, 10)
                    }
                }
                .frame(height: 48)
                .background(Color("white-Elevated1"))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(style: .init(lineWidth: 1))
                        .foregroundColor(Color("white-Elevated3"))
                )
                
                if isSecret {
                    Button {
                        self.isShow.toggle()
                    } label: {
                        Image(systemName: isShow ? "eye.slash" : "eye")
                     }
                    .frame(width: 28, height: 28)
                    .foregroundColor(Color("white-Elevated3"))
                    .padding(.trailing, 10)
                }
            }
            
            
        }
    }
}

struct AuthTextFiled_Previews: PreviewProvider {
    static var previews: some View {
        AuthTextFiled(
            placeholder: "아이디",
            isSecret: true,
            text: .constant("")
        )
    }
}
