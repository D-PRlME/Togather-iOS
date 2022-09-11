import SwiftUI

struct EmailVerify: View {
    
    var userEmail: String
    @State private var numberText: String = ""
    
    private func ButtonAtivation() -> Bool {
        if numberText.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 12) {
                
                Text("이메일 인증")
                    .font(.custom("Pretendard-Bold", size: 32))
                    .padding(.top, proxy.size.height / 6)
                
                Text("\(userEmail)로 전송된 n자리 인증 번호를 입력해 주세요. 인증 번호는 5분 후에 만료됩니다")
                    .font(.custom("Pretendard-Medium", size: 20))
                    .allowsTightening(true)
                
                TextField("인증 번호", text: $numberText)
                    .keyboardType(.asciiCapableNumberPad)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(.custom("Pretendard-Medium", size: 20))
                    .frame(height: 28)
                    .padding(12)
                    .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                    .cornerRadius(4)
                    .padding(1)
                    .background(Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                    .cornerRadius(6)
                
                
                GeometryReader { imageProxy in
                    Image("PostBox")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .position(x: imageProxy.size.width / 2, y: imageProxy.frame(in: .local).midY / 1.3)
                        .opacity(imageProxy.size.height > 170 ? 1 : 0)
                }
                .coordinateSpace(name: "imageGeometry")
                    
                
                Button(action: {
                     print("next")
                }) {
                    VStack(spacing: 0) {
                        Rectangle()
                            .frame(height: 0)
                        
                        Text("다음")
                            .font(.custom("Pretendard-Bold", size: 18))
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 13)
                    .background(ButtonAtivation() ? Color(red: 0.882, green: 0.678, blue: 0.004) : Color(red: 0.97, green: 0.97, blue: 0.97))
                    .cornerRadius(6)
                    .padding(2)
                    .background(ButtonAtivation() ? Color(red: 0.7, green: 0.6, blue: 0.004) : Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                    .cornerRadius(8)
                }
                .disabled(ButtonAtivation() == false)
            } //Vstack
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }
}

struct EmailVerify_Previews: PreviewProvider {
    static var previews: some View {
        EmailVerify(userEmail: "bjcho1503@dsm.hs.kr")
    }
}
