//
//  FlowLayout.swift
//  Togather
//
//  Created by 홍승재 on 2022/09/15.
//

import SwiftUI
import SwiftUIFlowLayout

struct TagsFlowLayout: View {
    var body: some View {
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
    }
}

struct TagsFlowLayout_Previews: PreviewProvider {
    static var previews: some View {
        TagsFlowLayout()
    }
}
