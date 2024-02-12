//
//  GridBoxView.swift
//  CVSChallenge
//
//  Created by Pradeep Kumar on 12/12/23.
//

import SwiftUI

struct GridBoxView<Content: View>: View {

    var content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 5.0)
                .fill(Color(UIColor(red: 255.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1)))
            VStack {
                self.content()
            }
        }
    }
}
