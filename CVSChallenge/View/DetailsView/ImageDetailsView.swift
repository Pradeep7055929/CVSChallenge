//
//  ImageDetailsView.swift
//  CVSChallenge
//
//  Created by Pradeep Kumar on 2/11/24.
//

import SwiftUI

struct ImageDetailsView: View {
    
    var viewModel: ImageDetailsViewModel
    @State private var showShareSheet = false
    
    var body: some View {
        ScrollView  {
                ImageView(urlString: self.viewModel.imageUrl)
                    .frame(height: 200).transition(.slide)
                VStack(alignment: .leading){
                    HStack(alignment: .top){
                        Text("Title: ")
                            .bold()
                        Text(self.viewModel.title)
                            .padding(.leading, 5)
                    }.padding()
                    HStack(alignment: .top){
                        Text("Author: ")
                            .bold()
                        Text(self.viewModel.author)
                            .padding(.leading, 5)
                    }.padding()
                    
                    HStack(alignment: .top){
                        Text("Published Date: ")
                            .bold()
                        Text(self.viewModel.publishedDate)
                            .padding(.leading, 5)
                    }.padding()
                    
                    Button(action: {
                        self.showShareSheet = true
                    }) {
                        Text("Share").bold()
                    }
                    .padding(.leading, 100)
                }
                .sheet(isPresented: $showShareSheet) {
                    ShareSheet(activityItems: [self.viewModel.imageUrl ?? "", self.viewModel.title, self.viewModel.author, self.viewModel.publishedDate])
                }
                
                Spacer()
            }.navigationBarTitle(self.viewModel.title)
             .navigationBarTitleDisplayMode(.inline)
    }
}
