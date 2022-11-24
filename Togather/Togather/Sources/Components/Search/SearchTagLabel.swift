import SwiftUI

struct SearchTagLabel: View {
    @Binding var tag: String
    var body: some View {
        if tag != "" {
            Text(tag)
                .foregroundColor(.white0)
                .font(.maintext2m)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.whiteElevated5)
                .cornerRadius(37)
        }
    }
}

struct SearchTagLabel_Previews: PreviewProvider {
    static var previews: some View {
        SearchTagLabel(tag: .constant("swift"))
    }
}
