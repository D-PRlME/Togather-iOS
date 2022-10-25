//
//  PostForm.swift
//  Togather
//
//  Created by 조병진 on 2022/10/25.
//

import SwiftUI
import SwiftUIFlowLayout
import Kingfisher

struct PostForm: View {
    @Binding var close: Bool
    @State var showAlert: Bool = false
    var postData: Posts
    var body: some View {
        Button {
            self.showAlert = true
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Text(postData.title)
                    .foregroundColor(.text)
                    .font(.title2b)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 5)
                
                FlowLayout(mode: .scrollable,
                           items: postData.tags,
                           itemSpacing: 3) {
                    Text($0.name)
                        .foregroundColor(.text)
                        .font(.maintext2m)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.whiteElevated2)
                        .cornerRadius(37)
                        .overlay(
                            RoundedRectangle(cornerRadius: 37)
                                .stroke(style: .init(lineWidth: 1))
                                .foregroundColor(.whiteElevated3)
                        )
                }
                
                Divider()
                
                HStack() {
                    KFImage.url(URL(string: postData.users.profile_image_url))
                        .placeholder {
                            Circle()
                                .fill(Color.whiteElevated2)
                        }
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 33, height: 33)
                        .padding(.horizontal, 4)
                        .overlay(Circle().stroke(lineWidth: 1).foregroundColor(.whiteElevated3))
                    
                    Text(postData.users.user_name)
                        .foregroundColor(.black)
                        .font(.maintext2m)
                    Spacer()
                    Image("GrayHeart")
                        .resizable()
                        .frame(width: 16, height: 13)
                    Text(String(postData.like_count))
                        .foregroundColor(.whiteElevated4)
                        .font(.maintext2m)
                    Image("SeperateBar")
                        .resizable()
                        .frame(width: 1, height: 15)
                    Text(postData.created_at)
                        .foregroundColor(.whiteElevated4)
                        .font(.maintext2m)
                }
                
            }
            .padding(12)
            .background(Color.whiteElevated1)
            .cornerRadius(8)
            .padding(.vertical, 6)
            .sheet(
                isPresented: $showAlert,
                onDismiss: {
                    self.close = true
                },
                content: {
                    PostDetail(
                        showModal: $showAlert,
                        postID: postData.post_id
                    )
                }
            )
        }
    }
}


//struct PostForm_Previews: PreviewProvider {
//    static var previews: some View {
//        PostForm()
//    }
//}
