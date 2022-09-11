//
//  Developers.swift
//  Draw
//
//  Created by 홍승재 on 2022/09/11.
//

import SwiftUI

struct Developers: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor1.ignoresSafeArea()
                VStack {
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
                    ScrollView(.vertical, showsIndicators: false) {
                        HStack {
                            Text("개발자들")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Bold", size: 28))
                                .padding(.top, 40)
                            Spacer()
                        }
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(0..<Developer.count, id: \.self) { i in
                                ZStack{
                                    VStack(spacing: 8) {
                                        HStack(spacing: 0) {
                                            Circle()
                                                .foregroundColor(DevColor[i])
                                                .frame(width: 62, height: 62)
                                            Spacer()
                                            Text(Developer[i])
                                                .foregroundColor(.black)
                                                .font(.custom("Pretendard-Bold", size: 24))
                                                .padding(.trailing, 8)
                                        }
                                        HStack {
                                            Text("기술")
                                                .foregroundColor(.black)
                                                .font(.custom("Pretendard-Medium", size: 16))
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                                .background(Color(red: 0.905, green: 0.905, blue: 0.905))
                                                .cornerRadius(37)
                                                .padding(1)
                                                .background(Color("TabBarStroke"))
                                                .cornerRadius(37)
                                            Spacer()
                                        }
                                        HStack(spacing: 0) {
                                            Image("LinkImage")
                                                .resizable()
                                                .frame(width: 12, height: 12)
                                                .padding(4)
                                            Text("Github")
                                                .foregroundColor(.black)
                                                .font(.custom("Pretendard-Medium", size: 18))
                                                .underline()
                                            Spacer()
                                        }
                                    }
                                }
                                .padding(12)
                                .background(Color("TabBarFill"))
                                .cornerRadius(8)
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct Developers_Previews: PreviewProvider {
    static var previews: some View {
        Developers()
    }
}
