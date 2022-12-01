//
//  OpponentChatSkeleton.swift
//  Togather
//
//  Created by 조병진 on 2022/11/30.
//

import SwiftUI

struct OpponentChatSkeleton: View {
    var line: Int = 1
    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            Circle()
                .frame(width: 48, height: 48)
                .foregroundColor(.whiteElevated3)
            VStack(alignment: .leading, spacing: 5) {
                Rectangle()
                    .frame(width: 60, height: 20)
                    .foregroundColor(.whiteElevated3)
                    .cornerRadius(10)
                Rectangle()
                    .frame(width: 180, height: 32 * CGFloat(line))
                    .foregroundColor(.whiteElevated3)
                    .cornerRadius(20)
            }
            Rectangle()
                .frame(width: 40, height: 15)
                .foregroundColor(.whiteElevated3)
                .cornerRadius(10)
            Spacer()
        }
    }
}

struct OpponentChatSkeleton_Previews: PreviewProvider {
    static var previews: some View {
        OpponentChatSkeleton()
    }
}
