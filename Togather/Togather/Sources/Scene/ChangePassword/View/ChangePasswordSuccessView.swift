import SwiftUI
import AVFoundation

struct ChangePasswordSuccessView: View {
    @State private var goHome: Bool = false
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 130)
                ChangePasswordTitle(
                    title: "비밀번호가\n변경되었어요",
                    subTitle: ""
                )
                GeometryReader { imageProxy in
                    Image("GreenCheck")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .position(x: imageProxy.frame(in: .local).midX, y: imageProxy.frame(in: .local).midY)
                }
                ChangePasswordButton(
                    isDisable: .constant(false),
                    title: "다음",
                    action: {
                        goHome = true
                    }
                )
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

struct ChangePasswordSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordSuccessView()
    }
}
