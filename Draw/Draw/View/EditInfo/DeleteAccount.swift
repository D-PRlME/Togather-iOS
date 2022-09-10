//
//  DeleteAccount.swift
//  Draw
//
//  Created by 홍승재 on 2022/09/10.
//

import SwiftUI

struct DeleteAccount: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var SamePW = false
    @State var password = ""
    @State var showAlert = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor1.ignoresSafeArea()
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Spacer()
                        Image("CloseBtn")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.trailing, 16)
                            .padding(.top, 16)
                            .onTapGesture {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                    }
                    Text("계정삭제")
                        .foregroundColor(.black)
                        .font(.custom("Pretendard-Bold", size: 28))
                        .padding(.top, 40)
                    Text("계정을 삭제하려면 비밀번호를 입력해 주세요.")
                        .foregroundColor(.black)
                        .font(.custom("Pretendard-Medium", size: 18))
                    Spacer()
                    Button {
                        if SamePW {
                            showAlert = true
                        }
                    } label: {
                        Text("계정 삭제")
                            .font(.custom("Pretendard-Bold", size: 18))
                            .foregroundColor(SamePW ?
                                .black : Color(red: 0.47, green: 0.47, blue: 0.47))
                            .frame(width: proxy.size.width - 32)
                            .padding(.vertical, 13)
                            .background(SamePW ?
                                        Color(red: 0.996, green: 0.239, blue: 0.239) :
                                            Color(red: 0.97, green: 0.97, blue: 0.97))
                            .cornerRadius(6)
                            .padding(2)
                            .background(SamePW ? Color("RedStroke") : Color("TabBarStroke"))
                            .cornerRadius(6)
                            .alert("정말 계정을 삭제하시겠습니까?", isPresented: $showAlert) {
                                Button("진행", role: .cancel) {}
                                Button("취소", role: .destructive) {}
                            } message: {
                                Text("모든 입력한 정보, 작성한 글이 서버에서 삭제되며 이 작업은 되돌릴 수 없습니다.")
                            }
                    }
                }
                .padding(.horizontal, 16)
                VStack {
                    HStack(spacing: 8) {
                        Image(systemName: "person.fill")
                            .frame(width: 48, height: 48)
                            .overlay(Circle().stroke().foregroundColor(Color("TabBarStroke")))
                        Text(Developer[0])
                            .foregroundColor(.black)
                            .font(.custom("Pretendard-Medium", size: 20))
                    }
                    SecureField("비밀번호", text: $password)
                        .font(.custom("Pretendard-Medium", size: 20))
                        .foregroundColor(.black)
                        .padding(.leading, 12)
                        .padding(.vertical, 10)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .cornerRadius(6)
                        .padding(1)
                        .background(Color("TabBarStroke"))
                        .cornerRadius(6)
                        .padding(.top, 8)
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 16)
            .navigationBarHidden(true)
        }
    }
}

struct DeleteAccount_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccount()
    }
}
