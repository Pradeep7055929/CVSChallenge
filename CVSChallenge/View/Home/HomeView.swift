//
//  HomeView.swift
//  CVSChallenge
//
//  Created by Pradeep Kumar on 2/10/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    @State private var searchTerm: String = "porcupine"
    @State var showLoader: Bool = true
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack() {
                SearchView(searchTerm: self.$searchTerm)
                if showLoader {
                    Spacer()
                    LoaderView(tintColor: .red, scaleSize: 3.0).padding(.bottom,50).hidden(!showLoader)
                } else {
                    if let images = viewModel.images {
                        FlickrImagesListView(images: images)
                    }
                }
                Spacer()
            }.navigationBarTitle("Images")
        }
        .onChange(of: searchTerm) { newValue in
            viewModel.fetchImages(searchString: newValue)
        }
        .onReceive(self.viewModel.isLoading) { isLoading in
            self.showLoader = isLoading
        }
    }
}

struct SecondView: View {
    var body: some View {
        Text("Second Screen")
            .navigationBarTitle("Second Screen")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
