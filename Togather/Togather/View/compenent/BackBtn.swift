//
//  BackBtn.swift
//  Togather
//
//  Created by 홍승재 on 2022/10/04.
//

import SwiftUI

struct BackBtn: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image("back")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .padding(.leading, 16)
                        .padding(.top, 8)
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct BackBtn_Previews: PreviewProvider {
    static var previews: some View {
        BackBtn()
    }
}
