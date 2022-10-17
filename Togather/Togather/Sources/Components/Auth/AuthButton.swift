import SwiftUI

struct AuthButton: View {
    @Binding var isDisable: Bool
    let text: String
    let action: () -> Void
    
    init (
        isDisable: Binding<Bool> = .constant(false),
        text: String,
        action: @escaping () -> Void
    ) {
        self._isDisable = isDisable
        self.text = text
        self.action = action
    }
    
    var body: some View {
        VStack {
            Button(action: action) {
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 0)
                    
                    Text(text)
                        .font(.custom("Pretendard-Bold", size: 18))
                        .foregroundColor(.black)
                        .padding(.vertical, 12)
                }
                .background(isDisable ? Color.whiteElevated1 : Color.main)
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(style: .init(lineWidth: 2))
                        .foregroundColor(isDisable ? Color.whiteElevated3 : Color.mainElevated)
                )
            } .disabled(isDisable)
        }
    }
}

struct AuthButton_Previews: PreviewProvider {
    static var previews: some View {
        AuthButton(
            isDisable: .constant(false),
            text: "로그인",
            action: { }
        )
    }
}
