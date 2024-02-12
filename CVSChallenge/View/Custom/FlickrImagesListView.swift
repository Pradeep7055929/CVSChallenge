//
//  FlickrImagesListView.swift
//  CVSChallenge
//
//  Created by Pradeep Kumar on 2/9/24.
//

import Foundation
import SwiftUI

struct FlickrImagesListView: View {
    
    var images = [ImageData]()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var isActive = false
    
    init(images: [ImageData]) {
        self.images = images
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 5.0)
                .fill(Color(UIColor(.white)))
            ScrollView {
                LazyVGrid(columns: self.columns, spacing: 20.0) {
                    ForEach(self.images, id: \.self) { imageData in
                        GridBoxView {
                            GeometryReader { geometryProxy in
                                if let imageUrl = imageData.media?.url {
                                    ImageView(urlString: imageUrl)
                                        .frame(width: (geometryProxy.size.width), height: (geometryProxy.size.height))
                                        .onTapGesture {
                                            self.isActive = true
                                        }
                                        .background(
                                            NavigationLink (
                                                destination: ImageDetailsView(viewModel: ImageDetailsViewModel(imageData: imageData) ).accessibilityLabel(Text("Clik the image to see details")), isActive: $isActive,
                                                label: {
                                                    EmptyView()
                                                }
                                            ))
                                }
                            }
                            .frame(height: 150)
                        }
                    }
                }
            }
            .padding(.top, 0)
            .padding(.horizontal, 20)
            Spacer()
        }
    }
}
