//
//  PostDetail.swift
//  Draw
//
//  Created by 홍승재 on 2022/09/10.
//

import SwiftUI
import SwiftUIFlowLayout

struct PostDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor1.ignoresSafeArea()
                VStack(spacing: 12) {
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
                    Text("제목제목제목제목제목제목제목제목제목제목제목")
                        .foregroundColor(.black)
                        .font(.custom("Pretendard-Bold", size: 24))
                        .padding(.top, 7)
                    HStack(spacing: 8) {
                        Image(systemName: "person.fill")
                            .frame(width: 33, height: 33)
                            .overlay(Circle().stroke().foregroundColor(Color("TabBarStroke")))
                        Text(Developer[0])
                            .foregroundColor(.black)
                            .font(.custom("Pretendard-Medium", size: 16))
                        Spacer()
                        Text("1시간 전")
                            .foregroundColor(.black)
                            .font(.custom("Pretendard-Medium", size: 16))
                    }
                    Rectangle()
                        .foregroundColor(Color("TabBarStroke"))
                        .frame(width: proxy.size.width - 32, height: 1)
                    FlowLayout(mode: .scrollable,
                               items: DevLanguage,
                               itemSpacing: 5) {index in
                        Text(index)
                            .foregroundColor(.black)
                            .font(.custom("Pretendard-Medium", size: 16))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(red: 0.905, green: 0.905, blue: 0.905))
                            .cornerRadius(37)
                            .padding(1)
                            .background(Color("TabBarStroke"))
                            .cornerRadius(37)
                    }
                    Text("내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용이 울부지저따“콰아아아아”내용이 울부짖자 대통령은 국무총리·국무위원·행정각부의 장 기타 법률이 정하는 공사의 직을 겸할 수 없다. 대통령은 헌법과 법률이 정하는 바에 의하여 국군을 통수해따.")
                        .foregroundColor(.black)
                        .font(.custom("Pretendard-Medium", size: 18))
                    Spacer()
                    HStack {
                        HStack(spacing: 8) {
                            Image("LinkImage")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .padding(4)
                            Text("연락하기")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Bold", size: 18))
                        }
                        .padding(.horizontal, 11)
                        .padding(.vertical, 5)
                        .background(Color(red: 0.882, green: 0.678, blue: 0.004))
                        .cornerRadius(37)
                        .padding(2)
                        .background(Color("YellowStroke"))
                        .cornerRadius(37)
                        Spacer()
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
    }
}

struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostDetail()
    }
}
