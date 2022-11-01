//
//  WritingButton.swift
//  Togather
//
//  Created by 조병진 on 2022/10/26.
//

import SwiftUI

struct PostButton: View {
    let title: String
    let backgroundColor: Color
    let cornerColor: Color
    let action: () -> Void
    
    init(
        title: String,
        backgroundColor: Color,
        cornerColor: Color,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.cornerColor = cornerColor
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.maintext1b)
                .foregroundColor(.text)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(backgroundColor)
                .cornerRadius(37)
                .overlay(
                    RoundedRectangle(cornerRadius: 37)
                        .stroke(lineWidth: 2)
                        .foregroundColor(cornerColor)
                )
        }
    }
}

struct WritingButton_Previews: PreviewProvider {
    static var previews: some View {
        PostButton(
            title: "글쓰기",
            backgroundColor: .main,
            cornerColor: .mainDarken,
            action: { }
        )
    }
}
