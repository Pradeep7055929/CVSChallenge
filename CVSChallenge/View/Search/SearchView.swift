//
//  SearchView.swift
//  CVSChallenge
//
//  Created by Pradeep Kumar on 2/10/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SeacrhViewModel()
    @Binding var searchTerm: String
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "magnifyingglass")
            
            TextField("Search Images", text: self.$viewModel.userInput)
                .foregroundColor(Color.primary)
                .padding(10)
                .accessibilityLabel(Text("Search the images"))
            
            Spacer()
        }.foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .padding(10)
        .onReceive(
            self.viewModel.$userInput.debounce(for: 1, scheduler: RunLoop.main)
        ) { seachTerm in
            self.searchTerm = seachTerm
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchTerm: .constant(""))
    }
}
