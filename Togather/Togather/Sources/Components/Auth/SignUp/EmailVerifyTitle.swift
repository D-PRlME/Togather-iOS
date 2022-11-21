import SwiftUI

struct EmailVerifyTitle: View {
    let email: String
    @Binding var second: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("이메일 인증")
                .font(.titleXLb)
                .foregroundColor(.text)
            Text("\(email)로 전송된 6자리 인증 번호를 입력해 주세요.\n인증 번호는 \(second)초 후에 만료됩니다")
                .font(.title3m)
                .foregroundColor(.text)
        }
    }
}

struct EmailVerifyTitle_Previews: PreviewProvider {
    static var previews: some View {
        EmailVerifyTitle(email: "bjcho1503@dsm.hs.kr", second: .constant(500))
    }
}
