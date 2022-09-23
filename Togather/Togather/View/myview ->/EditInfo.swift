//
//  EditInfo.swift
//  Draw
//
//  Created by 홍승재 on 2022/09/09.
//

import SwiftUI

struct EditInfo: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var name = ""
    @State var email = ""
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ZStack {
                    ColorManager.BackgroundColor1.ignoresSafeArea()
                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                            Image("CloseBtn")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.top, 16)
                                .onTapGesture {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                        }
                        HStack(spacing: 12) {
                            Image(systemName: "person.fill")
                                .frame(width: 48, height: 48)
                                .overlay(Circle().stroke().foregroundColor(Color("TabBarStroke")))
                                .padding(.leading, 10)
                            Text("이미지 변경")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Bold", size: 18))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color(red: 0.882, green: 0.678, blue: 0.004))
                                .cornerRadius(37)
                                .padding(2)
                                .background(Color("YellowStroke"))
                                .cornerRadius(37)
                            Spacer()
                        }
                        .padding(.top, 26)
                        TextField("홍승재", text: $name)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .font(.custom("Pretendard-Medium", size: 20))
                            .foregroundColor(.black)
                            .padding(12)
                            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                            .cornerRadius(6)
                            .padding(1)
                            .background(Color("TabBarStroke"))
                            .cornerRadius(6)
                            .padding(.top, 12)
                        TextField("gtw030488@gmail.com", text: $email)
                            .font(.custom("Pretendard-Medium", size: 20))
                            .foregroundColor(.black)
                            .padding(12)
                            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                            .cornerRadius(6)
                            .padding(1)
                            .background(Color("TabBarStroke"))
                            .cornerRadius(6)
                            .padding(.top, 8)
                        Spacer()
                        HStack {
                            Text("저장")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Bold", size: 18))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color(red: 0.882, green: 0.678, blue: 0.004))
                                .cornerRadius(37)
                                .padding(2)
                                .background(Color("YellowStroke"))
                                .cornerRadius(37)
                            Spacer()
                            NavigationLink(destination: DeleteAccount()) {
                                Text("계정 삭제")
                                    .foregroundColor(.black)
                                    .font(.custom("Pretendard-Bold", size: 18))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color(red: 0.995, green: 0.238, blue: 0.238))
                                    .cornerRadius(37)
                                    .padding(2)
                                    .background(Color("RedStroke"))
                                    .cornerRadius(37)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.bottom, 17)
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct EditInfo_Previews: PreviewProvider {
    static var previews: some View {
        EditInfo()
    }
}
