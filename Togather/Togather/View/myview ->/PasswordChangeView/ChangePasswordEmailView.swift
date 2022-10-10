//
//  ChangePasswordEmailView.swift
//  Togather
//
//  Created by 조병진 on 2022/10/10.
//

import SwiftUI

struct ChangePasswordEmailView: View {
    @State var email: String = ""
    
    func ButtonAtivation() -> Bool {
        return true
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
//                NavigationLink(destination: EnterNewPassword(), tag: 1, selection: $changePWToEmailVM.goEnterPW) { EmptyView() }
                VStack(alignment: .leading, spacing: 0) {
                    Text("비밀번호 변경")
                        .font(.custom("Pretendard-Bold", size: 32))
                        .padding(.top, proxy.size.height / 6)
                        .padding(.bottom, 10)
                    
                    Text("인증번호를 받기 위한 이메일 주소가 필요합니다")
                        .font(.custom("Pretendard-Medium", size: 20))
                        .padding(.bottom, 18)
                    
                    TextField("이메일", text: $email)
                        .keyboardType(.emailAddress)
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
                    
                    Spacer()
                    
                    Button(action: {
                        
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
                    .padding(.bottom, proxy.safeAreaInsets.bottom == 0 ? 30 : 5)
                } //Vstack
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .navigationBarHidden(true)
            BackBtn()
        }
    }
}

struct ChangePasswordEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordEmailView()
    }
}
