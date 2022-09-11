import SwiftUI

struct signUpSuccess: View {
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                Text("가입이\n완료되었어요")
                    .font(.custom("Pretendard-Bold", size: 32))
                    .padding(.horizontal, 16)
                    .padding(.top, proxy.size.height / 5)
                
                GeometryReader { imageProxy in
                    Image("GreenCheck")
                        .position(x: imageProxy.frame(in: .local).midX, y: imageProxy.frame(in: .local).midY)
                }
                
                
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
                    .background(Color(red: 0.882, green: 0.678, blue: 0.004))
                    .cornerRadius(6)
                    .padding(2)
                    .background(Color(red: 0.7, green: 0.6, blue: 0.004))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                    
                }
                .padding(.bottom, proxy.safeAreaInsets.bottom == 0 ? 30 : 5)
            }
            
        }
    }
}

struct signUpSuccess_Previews: PreviewProvider {
    static var previews: some View {
        signUpSuccess()
    }
}
