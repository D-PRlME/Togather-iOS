import SwiftUI

struct AuthButton: View {
    @Binding var isDisable: Bool
    @Binding var isLoading: Bool
    let text: String
    let action: () -> Void
    
    init (
        isDisable: Binding<Bool> = .constant(false),
        isLoading: Binding<Bool> = .constant(false),
        text: String,
        action: @escaping () -> Void
    ) {
        self._isDisable = isDisable
        self._isLoading = isLoading
        self.text = text
        self.action = action
    }
    
    var body: some View {
        VStack {
            Button(action: action) {
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 0)
                    
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .padding(.vertical, 14)
                    } else {
                        Text(text)
                            .font(.maintext1b)
                            .foregroundColor(.text)
                            .padding(.vertical, 13)
                    }
                }
                .background(isDisable ? Color.whiteElevated1 : Color.main)
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(style: .init(lineWidth: 2))
                        .foregroundColor(isDisable ? Color.whiteElevated3 : Color.mainDarken)
                )
            } .disabled(isDisable)
        }
    }
}

struct AuthButton_Previews: PreviewProvider {
    static var previews: some View {
        AuthButton(
            isDisable: .constant(false),
            isLoading: .constant(false),
            text: "로그인",
            action: { }
        )
    }
}
