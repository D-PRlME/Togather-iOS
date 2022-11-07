import SwiftUI
import Kingfisher

struct ChangePasswordButton: View {
    @Binding var isDisable: Bool
    var title: String
    var action: () -> Void
    
    init(
        isDisable: Binding<Bool>,
        title: String,
        action: @escaping () -> Void
    ) {
        self._isDisable = isDisable
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                Rectangle()
                    .frame(height: 0)
                
                Text(title)
                    .font(.maintext1b)
                    .foregroundColor(.text)
                    .padding(.vertical, 13)
            }
            .background(isDisable ? Color.whiteElevated1 : Color.main)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(style: .init(lineWidth: 2))
                    .foregroundColor(isDisable ? Color.whiteElevated3 : Color.mainDarken)
            )
        }.disabled(isDisable)
    }
}

struct ChangePasswordButton_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordButton(
            isDisable: .constant(false),
            title: "다음",
            action: { }
        )
    }
}
