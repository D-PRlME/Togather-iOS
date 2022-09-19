//
//  MyPost.swift
//  Draw
//
//  Created by 홍승재 on 2022/09/11.
//

import SwiftUI
import SwiftUIFlowLayout

struct MyPost: View {
    
    @State var GoPostDetail = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
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
                    ScrollView {
                        HStack {
                            Text("내 게시글 보기")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Bold", size: 28))
                                .padding(.top, 40)
                            Spacer()
                        }
                        ForEach(0..<6, id: \.self) { i in
                            Button {
                                GoPostDetail = true
                            } label: {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("제목제목제목제목제목제목제목제목제목제목제목")
                                        .foregroundColor(.black)
                                        .font(.custom("Pretendard-Bold", size: 24))
                                        .multilineTextAlignment(.leading)
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
                                            .padding(.trailing, 8)
                                            .padding(.bottom, 8)
                                    }
                                    Rectangle()
                                        .foregroundColor(Color("TabBarStroke"))
                                        .frame(width: proxy.size.width - 70, height: 1)
                                    HStack(spacing: 8) {
                                        Image(systemName: "person.fill")
                                            .foregroundColor(.black)
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
                                }
                                .padding(12)
                                .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                                .cornerRadius(8)
                            }
                            
                        }
//                        .sheet(isPresented: $GoPostDetail, content: {
//                            PostDetail(postID: <#Binding<Int>#>, showModal: <#Binding<Bool>#>)
//                        })
                        .padding(.vertical, 8)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }
}

struct MyPost_Previews: PreviewProvider {
    static var previews: some View {
        MyPost()
    }
}
