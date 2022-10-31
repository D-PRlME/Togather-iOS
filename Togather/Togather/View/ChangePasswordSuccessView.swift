import SwiftUI
import AVFoundation

struct ChangePasswordSuccess: View {
    @State private var goHome: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                Text("비밀번호가\n변경되었어요")
                    .font(.custom("Pretendard-Bold", size: 32))
                    .padding(.top, proxy.size.height / 5)
                
                GeometryReader { imageProxy in
                    Image("GreenCheck")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .position(x: imageProxy.frame(in: .local).midX, y: imageProxy.frame(in: .local).midY)
                }
                
                
                Button(action: {
                    goHome = true
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
                }
                .padding(.bottom, proxy.safeAreaInsets.bottom == 0 ? 30 : 5)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            .fullScreenCover(isPresented: $goHome) {
                TabBarView()
            }
        }
        .navigationBarHidden(true)
    }
}

struct ChangePasswordSuccess_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordSuccess()
    }
}
