import SwiftUI

struct ChangePasswordTitle: View {
    var title: String
    var subTitle: String
    init(
        title: String,
        subTitle: String
    ) {
        self.title = title
        self.subTitle = subTitle
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.titleXLb)
                .padding(.bottom, 10)
            Text(subTitle)
                .font(.title3m)
                .padding(.bottom, 18)
        }
    }
}

struct ChangePasswordTitle_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordTitle(title: "비밀번호 변경", subTitle: "비밀번호를 변경하려면 이런것들을 처요.")
    }
}
